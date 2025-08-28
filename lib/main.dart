// import 'package:flutter/material.dart';
// import 'package:travel_app/features/splash/splash_screen.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
//   }
// }

import 'package:flutter/material.dart';
import 'package:travel_app/core/colors_style.dart';
import 'package:travel_app/features/home/favourite.dart';
import 'package:travel_app/features/home/home_screen.dart';
import 'package:travel_app/features/home/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: ColorsStyle.primaryColor,

),

      home: const HomeScreen(),
    );
  }
}