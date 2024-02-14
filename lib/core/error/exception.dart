import 'package:firebase_auth_platform_interface/src/firebase_auth_exception.dart';

class ServerException implements Exception {}

class AuthException implements Exception {
  final String message;
  AuthException({required this.message});
}

class DatabaseException implements Exception {
  final String message;
  DatabaseException(this.message);
}
