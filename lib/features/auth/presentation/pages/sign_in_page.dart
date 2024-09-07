import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/common/widgets/loader.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/core/utils/show_snackbar.dart';
import 'package:news_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:news_app/features/home/presentation/pages/home_page.dart';
import 'package:news_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:news_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:news_app/features/auth/presentation/widgets/auth_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            if (state is AuthSuccess) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            }
            return Form(
              key: formKey1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign in',
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthField(
                    hintText: 'Email',
                    controller: _emailController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthField(
                    hintText: 'Password',
                    controller: _passwordController,
                    obsecureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthButton(
                    buttonText: 'Signin',
                    onpressed: () {
                      if (formKey1.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthSignInEvent(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const UserSignUp(),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                          text: "Don't have an account? ",
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.greyColor,
                                  ),
                          children: [
                            TextSpan(
                                text: "Sign up ",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: AppColors.textColor,
                                    ))
                          ]),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
