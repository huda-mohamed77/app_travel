import 'package:flutter/material.dart';
import 'package:travel_app/core/colors_style.dart';

class TimePage extends StatelessWidget {
  const TimePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(child: Text("🕒 Time Page",style: TextStyle(color: ColorsStyle.thrtineeColor,fontWeight: FontWeight.bold,fontSize: 28),));
  }
}
