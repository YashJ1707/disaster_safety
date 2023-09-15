import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();
  final String useridKey = "useridKey";
  final String usernameKey = "usernameKey";

// get login userid
  Future<String?> getUserId() async {
    return await storage.read(key: useridKey);
  }

  Future<void> setUserId(String? value) async {
    return await storage.write(key: useridKey, value: value);
  }

  Future<String?> getUsername() async {
    return await storage.read(key: usernameKey);
  }

  Future<void> setUsername(String? value) async {
    return await storage.write(key: usernameKey, value: value);
  }
}
