import 'package:dartz/dartz.dart';
import 'package:disaster_safety/core/error/failure.dart';
import 'package:disaster_safety/features/auth/data/model/user_model.dart';
import 'package:disaster_safety/features/auth/data/repository/auth_repository_impl.dart';
import 'package:disaster_safety/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'auth_bloc_test.mocks.dart';

@GenerateMocks([AuthRepositoryImpl])
void main() {
  late AuthBloc bloc;
  late MockAuthRepositoryImpl authRepository;
// laet MockAu
  setUp(() {
    authRepository = MockAuthRepositoryImpl();
    bloc = AuthBloc(authRepository: authRepository);
  });
  final UserModel mockUser = const UserModel(
      latitude: 34567,
      longitude: 5678,
      id: "id",
      name: "test",
      email: "test@test.com",
      role: "role");
  group("Auth BLoC tests", (() {
    test("Sign in test", () async {
      when(authRepository.login("email", "password"))
          .thenAnswer((_) async => Right(mockUser));

      bloc.add(const UserSignInEvent(email: "email", password: "password"));
      await untilCalled(authRepository.login("email", "password"));

      expect(bloc.state, AuthSuccessState(user: mockUser));
    });
  }));
}
