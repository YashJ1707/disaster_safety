import 'package:disaster_safety/core/router.dart';
import 'package:disaster_safety/features/auth/data/datasource/auth_datasource.dart';
import 'package:disaster_safety/features/auth/data/datasource/db_datasource.dart';
import 'package:disaster_safety/features/auth/data/repository/auth_repository_impl.dart';
import 'package:disaster_safety/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:disaster_safety/features/auth/presentation/widgets/auth_backgound.dart';
import 'package:disaster_safety/features/auth/presentation/widgets/auth_textfields.dart';
import 'package:disaster_safety/features/auth/presentation/widgets/buttons.dart';
import 'package:disaster_safety/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:disaster_safety/features/auth/presentation/widgets/auth_texts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthTexts authTexts = AuthTexts();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final AuthRepositoryImpl authRepository = AuthRepositoryImpl(
        authDatasource: AuthDatasourceImpl(), dbDatasource: DbDatasourceImpl());
    var _formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => AuthBloc(authRepository: authRepository),
      child: AuthBackgroundScaffold(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccessState) {
              //TODO: Persist user login
            }
          },
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return Loadings.staticLoader();
            } else
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 70.h),
                  authTexts.title("Welcome,"),
                  authTexts.subtitle("Glad to see you!"),
                  SizedBox(height: 25.h),
                  Form(
                    child: Column(
                      children: [
                        AuthTextField(
                          isPassword: false,
                          hint: "Email",
                          controller: emailController,
                        ),
                        SizedBox(height: 10),
                        AuthTextField(
                          isPassword: true,
                          hint: "Password",
                          controller: passwordController,
                        ),
                        forgotPasswordButton(),
                        (state is AuthFailureState)
                            ? Text(
                                state.message,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16.sp),
                              )
                            : Text(""),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  LoginButton(
                    "Login",
                    onPressed: () => context.read<AuthBloc>().add(
                        UserSignInEvent(
                            email: emailController.text,
                            password: passwordController.text)),
                  ),
                  SizedBox(height: 50.h),
                  Text(
                    "Or Login with",
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                  SizedBox(height: 20.h),
                  SocialLoginButtons(),
                  SizedBox(height: 150.h),
                  ChangeAuthTextButton(isLogin: true),
                ],
              );
          },
        ),
      ),
    );
  }

  Row forgotPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero)),
            onPressed: () {},
            child: Text(
              "Forgot Password?",
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
