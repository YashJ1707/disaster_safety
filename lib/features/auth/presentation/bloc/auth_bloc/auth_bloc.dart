import 'package:bloc/bloc.dart';
import 'package:disaster_safety/features/auth/data/model/user_model.dart';
import 'package:disaster_safety/features/auth/data/repository/auth_repository_impl.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryImpl authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitialState()) {
    on<UserSignInEvent>((event, emit) async {
      emit(AuthLoadingState());

      final userModel = await authRepository.login(event.email, event.password);

      if (userModel.isLeft()) {
      } else {
        // emit(AuthSuccessState(user: userModel.getOrElse(() => null)));
      }
    });
  }
}
