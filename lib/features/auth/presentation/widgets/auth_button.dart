import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_colors.dart';

class AuthButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onpressed;
  const AuthButton(
      {required this.buttonText, required this.onpressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.borderColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.transparentColor,
          shadowColor: AppColors.transparentColor,
          fixedSize: const Size(395, 55),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
