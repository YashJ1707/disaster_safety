import 'package:dartz/dartz.dart';
import 'package:disaster_safety/core/error/failure.dart';
import 'package:disaster_safety/features/auth/domain/entity/user.dart';
import 'package:disaster_safety/features/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecase.dart';

class Login extends UseCase<User, LoginParams> {
  final AuthRepoistory repoistory;

  Login({required this.repoistory});
  @override
  Future<Either<Failure, User>> call(LoginParams params) {
    return repoistory.login(params.username, params.passord);
  }
}

class LoginParams extends Equatable {
  final String username;
  final String passord;

  const LoginParams({required this.username, required this.passord});

  @override
  List<Object?> get props => [];
}
