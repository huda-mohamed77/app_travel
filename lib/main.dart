import 'package:flutter/material.dart';
import 'package:travel_app/features/placedetails/placedetails_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: DetailScreen());
  }
}
