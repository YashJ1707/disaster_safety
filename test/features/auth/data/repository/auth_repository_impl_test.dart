import 'package:dartz/dartz.dart';
import 'package:disaster_safety/core/error/exception.dart';
import 'package:disaster_safety/core/error/failure.dart';
import 'package:disaster_safety/features/auth/data/datasource/auth_datasource.dart';
import 'package:disaster_safety/features/auth/data/datasource/db_datasource.dart';
import 'package:disaster_safety/features/auth/data/repository/auth_repository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../firebase_mock.dart';
import 'auth_repository_impl_test.mocks.dart';

@GenerateMocks([AuthDatasourceImpl, DbDatasourceImpl, UserCredential, User])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthDatasourceImpl authDatasource;
  late MockDbDatasourceImpl dbDatasource;
  late MockUserCredential userCredential;
  late MockUser user;

  setupFirebaseAuthMocks();

  setUp(() async {
    await Firebase.initializeApp();
    user = MockUser();
    userCredential = MockUserCredential();
    authDatasource = MockAuthDatasourceImpl();
    dbDatasource = MockDbDatasourceImpl();
    repository = AuthRepositoryImpl(
        authDatasource: authDatasource, dbDatasource: dbDatasource);
  });

  group("delete user tests", () {
    test("successful delete test", (() {
      when(authDatasource.deleteUser("test").then((value) => (null)));

      repository.delteAccount("test", "test");

      verify(authDatasource.deleteUser("test"));
    }));

    test("unsuccessful delete attempt", (() async {
      when(authDatasource.deleteUser("test"))
          .thenThrow(AuthException(message: "something"));

      final response = await repository.delteAccount("test", "test");

      verify(authDatasource.deleteUser("test"));

      expect(response, Left(AuthFailure(message: "something")));
    }));
  });

  group("login tests", () {
    test("user not found failure test", (() async {
      when(authDatasource.usernameLogin("email", "password"))
          .thenThrow(AuthException(message: "User not found"));

      final response = await repository.login("email", "password");

      // verify(authDatasource.usernameLogin("email", "passowrd"));

      expect(response, Left(AuthFailure(message: "User not found")));
    }));

    test("invalid credentials test", (() async {
      when(authDatasource.usernameLogin("email", "password"))
          .thenThrow(AuthException(message: "Invalid Credentials"));

      final response = await repository.login("email", "password");

      // verify(authDatasource.usernameLogin("email", "passowrd"));

      expect(response, Left(AuthFailure(message: "Invalid Credentials")));
    }));
  });
}
