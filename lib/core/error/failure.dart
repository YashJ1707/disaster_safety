import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure({required this.message});
  @override
  List<Object?> get props => [];
}

class AuthFailure extends Failure {
  AuthFailure({required super.message});
}

class DatabaseFailure extends Failure {
  DatabaseFailure({required super.message});
}

class MapsFailure extends Failure {
  MapsFailure({required super.message});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});
}
