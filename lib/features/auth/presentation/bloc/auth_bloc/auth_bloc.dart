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
      if (event.email == "") {
        emit(AuthFailureState(message: "Email cannot be empty"));
      } else if (!isEmail(event.email)) {
        emit(AuthFailureState(message: "Invalid Email"));
      } else if (event.password.length < 6) {
        emit(AuthFailureState(
            message: "Password should be more than 6 characters"));
      } else {
        emit(AuthLoadingState());

        final userModelOrError =
            await authRepository.login(event.email, event.password);

        userModelOrError.fold((l) {
          emit(AuthFailureState(message: l.message));
        }, (r) => emit(AuthSuccessState(user: r)));
      }
    });

    //Sign Up
    on<UserSignupEvent>((event, emit) async {
      if (event.name == "") {
        emit(AuthFailureState(message: "Name cannot be empty"));
      } else if (event.email == "") {
        emit(AuthFailureState(message: "Email cannot be empty"));
      } else if (!isEmail(event.email)) {
        emit(AuthFailureState(message: "Invalid Email"));
      } else if (event.password.length < 6) {
        emit(AuthFailureState(
            message: "Password should be more than 6 characters"));
      } else if (event.password != event.confirmPassword) {
        emit(AuthFailureState(
            message: "Passowrd and Confirm Password do not match"));
      } else {
        emit(AuthLoadingState());
        //TODO: get current location and update location
        final UserModel user = UserModel(
            latitude: 0,
            longitude: 0,
            id: "id",
            name: event.name,
            email: event.email,
            role: "user");
        final signUpOrFailure =
            await authRepository.signUp(user, event.password);

        signUpOrFailure.fold((l) => emit(AuthFailureState(message: l.message)),
            (r) => emit(SignupSuccessState()));
      }
      if (state is AuthFailureState) {
        await Future.delayed(Duration(seconds: 3));
        emit(AuthInitialState());
      }
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

  bool isEmail(String text) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(text);
  }
}
