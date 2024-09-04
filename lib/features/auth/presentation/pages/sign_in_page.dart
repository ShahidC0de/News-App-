import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_colors.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
              onpressed: () {},
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
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.greyColor,
                        ),
                    children: [
                      TextSpan(
                          text: "Sign up ",
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppColors.textColor,
                                  ))
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
