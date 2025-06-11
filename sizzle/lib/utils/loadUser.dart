import 'dart:convert';
import '../entities/UserDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<UserDetails?> loadUserFromSecureStorage() async {
  try {
    final _secureStorage = FlutterSecureStorage();
    final name = await _secureStorage.read(key: 'user_name');
    final email = await _secureStorage.read(key: 'user_email');
    final phoneNo = await _secureStorage.read(key: 'user_phoneNo');
    final photoUrl = await _secureStorage.read(key: 'user_photoUrl');
    final addressJson = await _secureStorage.read(key: 'user_address');
    final lastUsedAddressJson =
        await _secureStorage.read(key: 'user_lastUsedAddress');

    List<Address>? addressList;
    if (addressJson != null && addressJson != 'null') {
      try {
        final decoded = json.decode(addressJson);
        if (decoded is List) {
          addressList = decoded
              .map((e) => Address.fromJson(e as Map<String, dynamic>))
              .toList();
        }
      } catch (e) {
        print("Error decoding address list: $e");
      }
    }

    Address? lastUsedAddress;
    if (lastUsedAddressJson != null && lastUsedAddressJson != 'null') {
      try {
        final decoded = json.decode(lastUsedAddressJson);
        if (decoded is Map<String, dynamic>) {
          lastUsedAddress = Address.fromJson(decoded);
        }
      } catch (e) {
        print("Error decoding last used address: $e");
      }
    }

    // Avoid returning a completely empty user if all values are null
    if (name == null &&
        email == null &&
        phoneNo == null &&
        photoUrl == null &&
        addressList == null &&
        lastUsedAddress == null) {
      return null;
    }

    return UserDetails(
      name: name,
      email: email,
      phoneNo: phoneNo,
      photoUrl: photoUrl,
      address: addressList,
      lastUsedAddress: lastUsedAddress,
    );
  } catch (e) {
    print("Error reading user from secure storage: $e");
    return null;
  }
}
