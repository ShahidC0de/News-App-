import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_colors.dart';
import 'package:news_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:news_app/features/home/presentation/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
     _checkAuthState(context);
    });
  }
  void _checkAuthState(BuildContext context){
    final session = Supabase.instance.client.auth.currentSession;
    if (session !=null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const HomePage()));
      
    }
    else{
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const SignInPage()));

      
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'N E W S   A P P ',
              style: TextStyle(
                color: AppColors.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
