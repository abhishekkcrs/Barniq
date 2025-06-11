import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:sizzle/entities/UserDetails.dart';

final baseUrl = dotenv.env['API_BASE_URL'];

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn();
});

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

class AuthState {
  final UserDetails? user;
  final bool isLoading;
  final String? error;
  final String? backendToken;

  AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.backendToken,
  });

  AuthState copyWith({
    UserDetails? user,
    bool? isLoading,
    String? error,
    String? backendToken,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      backendToken: backendToken ?? this.backendToken,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FlutterSecureStorage _secureStorage;

  AuthNotifier(
    this._firebaseAuth,
    this._googleSignIn,
    this._secureStorage,
  ) : super(AuthState(isLoading: true)) {
    // Initialize with a post-frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initialize();
    });
  }

  Future<void> _initialize() async {
    try {
      // Wait for Firebase to initialize
      await Future.delayed(const Duration(seconds: 1));

      // Listen to auth state changes
      _firebaseAuth.authStateChanges().listen((user) {
        if (mounted) {
          state = state.copyWith(isLoading: false);
        }
      });
    } catch (e) {
      if (mounted) {
        state = state.copyWith(
          user: null,
          isLoading: false,
          error: e.toString(),
        );
      }
    }
  }

  Future<void> checkExistingAuth() async {
    try {
      state = state.copyWith(isLoading: true);

      // Check for token in secure storage
      final token = await _secureStorage.read(key: 'token');
      print(
          'Checking token: ${token != null ? 'Token exists' : 'No token found'}');

      if (token != null) {
        try {
          // Verify token with backend
          final response = await http.post(
            Uri.parse('$baseUrl:8081/auth/verify'),
            headers: {
              'JWT-X-Header': 'Bearer $token',
            },
          );

          print('Token verification response: ${response.statusCode}');

          if (response.statusCode == 200) {
            await getCurrentUser();
            state = state.copyWith(
              backendToken: token,
              isLoading: false,
            );
            print('Token verified successfully');
          } else {
            print('Token verification failed: ${response.statusCode}');
            // Clear invalid token
            await _secureStorage.deleteAll();
            state = state.copyWith(
              backendToken: null,
              isLoading: false,
            );
          }
        } catch (e) {
          print('Error verifying token: $e');
          // Clear token on error
          await _secureStorage.deleteAll();
          state = state.copyWith(
            backendToken: null,
            isLoading: false,
            error: 'Token verification failed',
          );
        }
      } else {
        print('No token found in secure storage');
        state = state.copyWith(
          backendToken: null,
          isLoading: false,
        );
      }
    } catch (e) {
      print('Error in checkExistingAuth: $e');
      state = state.copyWith(
        user: null,
        backendToken: null,
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  String? _verificationId;

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    state = state.copyWith(isLoading: true);
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieval (Android)
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          state = state.copyWith(
            isLoading: false,
            error: 'OTP verification failed: ${e.message}',
          );
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          state = state.copyWith(isLoading: false);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to send OTP: $e',
      );
    }
  }

  //////////////////////////////////////////

  Future<void> getCurrentUser() async {
    final token = await _secureStorage.read(key: 'token');
    print(
        'Checking token: ${token != null ? 'Token exists' : 'No token found'}');

    if (token != null) {
      try {
        // Verify token with backend
        final response = await http.get(
          Uri.parse('$baseUrl:8083/users'),
          headers: {
            'JWT-X-Header': 'Bearer $token',
          },
        );
        print("JWT token is: $token");
        if (response.statusCode == 200) {
          final Map<String, dynamic> jsonData = json.decode(response.body);

          final user = UserDetails.fromJson(jsonData);

          // Store relevant fields in secure storage
          await _secureStorage.write(key: 'user_name', value: user.name);
          await _secureStorage.write(key: 'user_email', value: user.email);
          await _secureStorage.write(key: 'user_phoneNo', value: user.phoneNo);
          await _secureStorage.write(
              key: 'user_photoUrl', value: user.photoUrl);
          await _secureStorage.write(
              key: 'user_address',
              value:
                  json.encode(user.address?.map((e) => e.toJson()).toList()));
          await _secureStorage.write(
              key: 'user_lastUsedAddress',
              value: json.encode(user.lastUsedAddress?.toJson()));
          print("User data stored securely.");
          final allValues = await _secureStorage.readAll();
          allValues.forEach((key, value) {
            print('Key: $key, Value: $value');
          });

          state = state.copyWith(user: user);
        } else {
          print("Failed to fetch user: ${response.statusCode}");
          throw Exception("Failed to fetch user.");
        }
      } catch (e) {
        print("Error fetching user: $e");
      }
    }
  }

  //////////////////////////////////////////

  Future<void> verifyOtp(String smsCode) async {
    if (_verificationId == null) {
      state = state.copyWith(error: 'No verification ID found');
      return;
    }

    try {
      state = state.copyWith(isLoading: true);

      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );

      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        final idToken = await firebaseUser.getIdToken();

        final response = await http.post(
          Uri.parse('$baseUrl:8081/auth/firebase'),
          headers: {
            'Authorization': 'Bearer $idToken',
            'Content-Type': 'application/json',
          },
        );

        if (response.statusCode == 200) {
          final token = jsonDecode(response.body)['token'];
          await _secureStorage.write(key: 'token', value: token);
          await getCurrentUser();
          state = state.copyWith(
            backendToken: token,
            isLoading: false,
          );
        } else {
          await _firebaseAuth.signOut();
          await _secureStorage.delete(key: 'token');
          throw Exception('Backend validation failed');
        }
      }
    } catch (e) {
      await _firebaseAuth.signOut();
      await _secureStorage.delete(key: 'token');
      state = state.copyWith(
        user: null,
        backendToken: null,
        isLoading: false,
        error: 'OTP Sign-in failed: $e',
      );
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      state = state.copyWith(isLoading: true);

      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        state = state.copyWith(isLoading: false);
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Get Firebase user but don't update state yet
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      final firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        String? idToken = await firebaseUser.getIdToken(true);
        print("Id token: $idToken");
        print("Sending a post request to: $baseUrl:8081/auth/firebase");

        try {
          // Call backend
          final response = await http.post(
            Uri.parse('$baseUrl:8081/auth/firebase'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $idToken',
            },
          );
          print("Response: ${response.statusCode}");

          if (response.statusCode == 200) {
            final token = jsonDecode(response.body)['token'];

            // Store token securely
            await _secureStorage.write(key: 'token', value: token);
            await getCurrentUser();

            // Only update state with user and token if backend validation succeeds
            state = state.copyWith(
              backendToken: token,
              isLoading: false,
            );
          } else {
            // Backend error: sign out Firebase and clean up
            await _firebaseAuth.signOut();
            await _secureStorage.delete(key: 'token');
            throw Exception(
                'Backend authentication failed: ${response.statusCode}');
          }
        } catch (e) {
          // If backend call fails, sign out from Firebase
          await _firebaseAuth.signOut();
          await _secureStorage.delete(key: 'token');
          throw Exception('Backend validation failed: $e');
        }
      }
    } catch (e) {
      // Ensure Firebase sign out and cleanup on any error
      await _firebaseAuth.signOut();
      await _secureStorage.delete(key: 'token');
      state = state.copyWith(
        user: null,
        backendToken: null,
        isLoading: false,
        error: 'Login failed: $e',
      );
    }
  }

  Future<void> signOut() async {
    try {
      state = state.copyWith(isLoading: true);
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      await _secureStorage.deleteAll();
      state = state.copyWith(user: null, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        user: null,
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  final googleSignIn = ref.watch(googleSignInProvider);
  final secureStorage = ref.watch(secureStorageProvider);

  return AuthNotifier(firebaseAuth, googleSignIn, secureStorage);
});
