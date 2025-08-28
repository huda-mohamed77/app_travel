import 'package:flutter/material.dart';
import 'package:travel_app/core/colors_style.dart';
import 'package:travel_app/core/text_style.dart';
import 'package:travel_app/features/auth/signup/signup_screan.dart';
import 'package:travel_app/features/auth/widget/custom_button.dart';
import 'package:travel_app/features/auth/widget/custom_textfeild.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final formKey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsStyle.background,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsetsGeometry.all(15),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text('login', style: AppTextStyle.blackHeaderText),
                SizedBox(height: 40),
                CustmsTextfeid(
                  controller: emailcontroller,
                  lable: "Email",
                  icon: Icon(color: Color(0xFF1F2E4C), Icons.email),
                  obscure: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email is required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                CustmsTextfeid(
                  lable: "Password",
                  icon: Icon(color: Color(0xFF1F2E4C), Icons.key),
                  obscure: true,

                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return "pasword is required";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                CustomButton(onPressed: () {}, title: 'Login'),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupScrean(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
