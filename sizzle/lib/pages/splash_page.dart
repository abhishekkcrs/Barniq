import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sizzle/providers/auth_provider.dart';
import 'package:sizzle/routes.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final authNotifier = ref.read(authProvider.notifier);

    // Log secure storage contents
    const secureStorage = FlutterSecureStorage();
    final allValues = await secureStorage.readAll();
    print('Secure Storage Contents:');
    allValues.forEach((key, value) {
      print('$key: $value');
    });

    print("Checking the AuthState of the user and validating the token");
    print('checkExistingAuth');
    await authNotifier.checkExistingAuth();
    final authState = ref.read(authProvider);

    if (!mounted) return;

    if (authState.backendToken != null) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    } else {
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFF8E1), Color(0xFFFFF3E0), Color(0xFFFFF8E1)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/core/icon.png',
                width: 400,
                height: 400,
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading image: $error');
                  return const Icon(Icons.shopping_bag, size: 150);
                },
              ),
              const SizedBox(height: 24),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
