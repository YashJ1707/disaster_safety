part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthFailureState extends AuthState {
  final String message;

  const AuthFailureState({required this.message});

  @override
  List<Object> get props => [message];
}

final class AuthSuccessState extends AuthState {
  final UserModel user;

  const AuthSuccessState({required this.user});

  @override
  List<Object> get props => [user];
}

final class AuthEmailSentState extends AuthState {
  // final String
}
