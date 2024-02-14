import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthFailure extends Failure {
  final String message;

  AuthFailure({required this.message});
}

class DatabaseFailure extends Failure {
  final String message;

  DatabaseFailure({required this.message});
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({required this.message});
}
