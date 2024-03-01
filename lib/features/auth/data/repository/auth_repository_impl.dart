// ignore_for_file: avoid_print, void_checks
import 'package:dartz/dartz.dart';
import 'package:disaster_safety/core/error/exception.dart';
import 'package:disaster_safety/core/error/failure.dart';
import 'package:disaster_safety/features/auth/data/datasource/auth_datasource.dart';
import 'package:disaster_safety/features/auth/data/datasource/db_datasource.dart';
import 'package:disaster_safety/features/auth/data/model/user_model.dart';
import 'package:disaster_safety/features/auth/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepoistory {
  final AuthDatasourceImpl authDatasource;
  final DbDatasourceImpl dbDatasource;

  AuthRepositoryImpl(
      {required this.authDatasource, required this.dbDatasource});

  @override
  Future<Either<Failure, void>> delteAccount(String uid, String email) async {
    try {
      await authDatasource.deleteUser(email);
      await dbDatasource.removeData(uid);
      return const Right(());
    } catch (e) {
      return Left(AuthFailure(message: (e as AuthException).message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> login(
      String email, String password) async {
    try {
      final User response = await authDatasource.usernameLogin(email, password);
      final userData = await dbDatasource.getUserData(uid: response.uid);
      return Right(userData);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message!));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> signUp(UserModel user, String password) async {
    try {
      final UserCredential credential =
          await authDatasource.signUp(user.email, password);
      try {
        await dbDatasource.addUserData(user, credential);
      } on ServerException catch (e) {
        authDatasource.deleteUser(user.email);
        return Left(ServerFailure(message: e.message!));
      } on DatabaseException catch (e) {
        authDatasource.deleteUser(user.email);
        return Left(DatabaseFailure(message: e.message));
      }
      return const Right(());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message!));
    } on DatabaseException catch (e) {
      print(e.message);
      return Left(DatabaseFailure(message: e.message));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateAccount(UserModel user) async {
    try {
      await dbDatasource.updateUserData(user);
    } catch (e) {
      return Left(DatabaseFailure(message: (e as DatabaseException).message));
    }
    return Left(AuthFailure(message: "something went wrong"));
  }

  @override
  Future<Either<Failure, void>> confirmResetPassord(
      String email, String code, String password) async {
    try {
      await authDatasource.confirmPasswordResetCode(email, code, password);
      return const Right(());
    } catch (e) {
      return Left(AuthFailure(message: (e as AuthException).message));
    }
  }

  @override
  Future<Either<Failure, void>> sendresetPassordEmail(String email) async {
    try {
      await authDatasource.sendResetCode(email);
      return const Right(());
    } catch (e) {
      return Left(AuthFailure(message: (e as AuthException).message));
    }
  }
}
