part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class UserSignInEvent extends AuthEvent {
  final String email;
  final String password;

  const UserSignInEvent({required this.email, required this.password});
}

final class UserSignupEvent extends AuthEvent {
  final String email;
  final String name;
  final String password;
  final String confirmPassword;

  const UserSignupEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
}

final class SendResetEmailEvent extends AuthEvent {
  final String email;

  const SendResetEmailEvent({required this.email});
}

final class ConfirmResetEvent extends AuthEvent {
  final String email;
  final String code;
  final String password;

  const ConfirmResetEvent(
      {required this.email, required this.code, required this.password});
}

final class UserLogoutEvent extends AuthEvent {}

final class UserAccountDeleteEvent extends AuthEvent {
  final String email;
  final String uid;

  const UserAccountDeleteEvent(this.uid, {required this.email});
}
