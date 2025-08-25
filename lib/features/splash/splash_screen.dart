import 'dart:async';

import 'package:flutter/material.dart';
import 'package:travel_app/core/text_style.dart';
import 'package:travel_app/features/auth/login/login_screan.dart';
// import 'package:travel_app/core/colors_style.dart';
// import 'package:flutter_application_22/fetures/splash/splash_screan2.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorsStyle.background,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF366EA1),
              Color(0xFF375183),
              Color(0xFF1F2E4C),
            ], // الألوان
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Travel', style: AppTextStyle.heading1),
                  SizedBox(width: 8),
                  Image.asset("assets/image.png"),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Find Your Dream Destination With Us',
                style: AppTextStyle.heading2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
