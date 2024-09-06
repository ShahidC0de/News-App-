import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/common/widgets/loader.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/core/utils/show_snackbar.dart';
import 'package:news_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:news_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:news_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:news_app/features/auth/presentation/widgets/auth_field.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({super.key});

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final formkey = GlobalKey<FormState>();

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
              showSnackBar(context, "Please confirm your email and sign in");
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const SignInPage(),
                ),
              );
            }
            return Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign Up.',
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
                    hintText: 'Name',
                    controller: nameController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthField(
                    hintText: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthField(
                    hintText: 'Password',
                    controller: passwordController,
                    obsecureText: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthButton(
                    onpressed: () {
                      if (formkey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              AuthSignupEvent(
                                  email: emailController.text,
                                  name: nameController.text,
                                  password: passwordController.text),
                            );
                      }
                    },
                    buttonText: 'Signup',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInPage(),
                        ),
                      );
                    },
                    child: RichText(
                        text: TextSpan(
                            text: "Already have an account? ",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: AppColors.greyColor,
                                ),
                            children: [
                          TextSpan(
                              text: 'Sign in',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: AppColors.borderColor,
                                  ))
                        ])),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
