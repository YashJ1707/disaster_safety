import 'package:dartz/dartz.dart';
import 'package:disaster_safety/core/error/failure.dart';
import 'package:disaster_safety/features/auth/data/model/user_model.dart';

abstract class AuthRepoistory {
  Future<Either<Failure, UserModel>> login(String email, String password);
  Future<Either<Failure, void>> signUp(UserModel user, String password);
  Future<Either<Failure, void>> sendresetPassordEmail(String email);
  Future<Either<Failure, void>> confirmResetPassord(
      String email, String code, String password);
  Future<Either<Failure, void>> delteAccount(String uid, String email);
  Future<Either<Failure, UserModel>> updateAccount(UserModel user);
}
