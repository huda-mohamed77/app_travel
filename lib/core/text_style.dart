import 'package:flutter/material.dart';

class AppTextStyle {
  static const TextStyle heading1 = TextStyle(
    fontSize: 50,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    color: Colors.white,
  );

  static const TextStyle blackHeaderText = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.blueGrey,
  );

  static const TextStyle heading2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    wordSpacing: 4,
  );

  static const TextStyle whiteHeaderText = TextStyle(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle whiteSubText = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
}
