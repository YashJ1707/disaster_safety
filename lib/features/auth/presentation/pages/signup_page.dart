import 'package:disaster_safety/core/router.dart';
import 'package:disaster_safety/core/router/app_router_const.dart';
import 'package:disaster_safety/features/auth/data/datasource/auth_datasource.dart';
import 'package:disaster_safety/features/auth/data/datasource/db_datasource.dart';
import 'package:disaster_safety/features/auth/data/repository/auth_repository_impl.dart';
import 'package:disaster_safety/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:disaster_safety/features/auth/presentation/widgets/auth_backgound.dart';
import 'package:disaster_safety/features/auth/presentation/widgets/auth_textfields.dart';
import 'package:disaster_safety/features/auth/presentation/widgets/buttons.dart';
import 'package:disaster_safety/shared/loading.dart';
import 'package:disaster_safety/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:disaster_safety/features/auth/presentation/widgets/auth_texts.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthTexts authTexts = AuthTexts();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    var _formKey = GlobalKey<FormState>();
    final AuthRepositoryImpl authRepository = AuthRepositoryImpl(
        authDatasource: AuthDatasourceImpl(), dbDatasource: DbDatasourceImpl());

    return AuthBackgroundScaffold(
      child: BlocProvider(
        create: (context) => AuthBloc(authRepository: authRepository),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SignupSuccessState)
              context.goNamed(AppRouterConstants.loginRouteName);
          },
          builder: (context, state) {
            if (state is AuthLoadingState) return Loadings.staticLoader();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 70.h),
                authTexts.title("Create Account"),
                authTexts.subtitle("to get started now!"),
                SizedBox(height: 25.h),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AuthTextField(
                          isPassword: false,
                          hint: "Name",
                          controller: nameController,
                        ),
                        SizedBox(height: 10),
                        AuthTextField(
                          isPassword: false,
                          hint: "Email Address",
                          controller: emailController,
                        ),
                        SizedBox(height: 10),
                        AuthTextField(
                          isPassword: true,
                          hint: "Password",
                          controller: passwordController,
                        ),
                        SizedBox(height: 10),
                        AuthTextField(
                          isPassword: false,
                          isObscure: true,
                          hint: "Confrim Password",
                          controller: confirmPasswordController,
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
                    )),
                SizedBox(height: 20.h),
                LoginButton(
                  "Continue",
                  onPressed: () => context.read<AuthBloc>().add(UserSignupEvent(
                      name: nameController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      confirmPassword: confirmPasswordController.text)),
                ),
                SizedBox(height: 50.h),
                Text(
                  "Or Login with",
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                ),
                SizedBox(height: 20.h),
                SocialLoginButtons(),
                SizedBox(height: 80.h),
                ChangeAuthTextButton(isLogin: false),
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
