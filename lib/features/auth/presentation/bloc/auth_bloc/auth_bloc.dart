import 'package:bloc/bloc.dart';
import 'package:disaster_safety/core/error/failure.dart';
import 'package:disaster_safety/features/auth/data/model/user_model.dart';
import 'package:disaster_safety/features/auth/data/repository/auth_repository_impl.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryImpl authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitialState()) {
    //Sign In
    on<UserSignInEvent>((event, emit) async {
      emit(AuthLoadingState());

      final userModelOrError =
          await authRepository.login(event.email, event.password);

      userModelOrError.fold((l) => emit(AuthFailureState(message: l.message)),
          (r) => emit(AuthSuccessState(user: r)));
    });

    //Sign Up
    on<UserSignupEvent>((event, emit) async {
      emit(AuthLoadingState());

      final signUpOrFailure =
          await authRepository.signUp(event.user, event.password);

      signUpOrFailure.fold((l) => emit(AuthFailureState(message: l.message)),
          (r) => AuthInitialState());
    });

    //Delete Account
    on<UserAccountDeleteEvent>((event, emit) async {
      emit(AuthLoadingState());

      final delteAccountOrFailure =
          await authRepository.delteAccount(event.uid, event.email);

      delteAccountOrFailure.fold(
          (l) => AuthFailure(message: l.message), (r) => AuthInitialState());
    });

    //Forgot password
    on<SendResetEmailEvent>((event, emit) async {
      emit(AuthLoadingState());

      final sendResetEmail =
          await authRepository.sendresetPassordEmail(event.email);

      sendResetEmail.fold(
          (l) => AuthFailure(message: l.message), (r) => AuthEmailSentState());
    });

    on<ConfirmResetEvent>((event, emit) async {
      emit(AuthLoadingState());

      final confirmRestetOrFailure = await authRepository.confirmResetPassord(
          event.email, event.code, event.password);

      confirmRestetOrFailure.fold(
          (l) => AuthFailure(message: l.message), (r) => AuthInitialState());
    });
  }
}
