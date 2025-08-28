import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/colors_style.dart';
import 'package:travel_app/core/text_style.dart';
import 'package:travel_app/features/auth/cubit/auth_logic.dart';
import 'package:travel_app/features/auth/cubit/auth_state.dart';
import 'package:travel_app/features/auth/login/login_screan.dart';
import 'package:travel_app/features/auth/widget/custom_button.dart';
import 'package:travel_app/features/auth/widget/custom_textfeild.dart';
// import 'package:travel_app/features/home/home_screen.dart';

// ignore: must_be_immutable
class SignupScrean extends StatelessWidget {
  SignupScrean({super.key});

  final formKey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passordcontroller = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsStyle.background,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (_) => HomeScreen()),
              // );
            }
          },
          builder: (context, state) {
            final cubit = context.read<AuthCubit>();
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Text('Sign Up', style: AppTextStyle.blackHeaderText),
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
                      controller: userNameController,

                      obscure: false,
                      lable: "Username",
                      icon: Icon(color: Color(0xFF1F2E4C), Icons.person),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Username is required";
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 30),
                    CustmsTextfeid(
                      controller: passordcontroller,
                      lable: "Password",
                      icon: Icon(color: Color(0xFF1F2E4C), Icons.key),
                      obscure: true,

                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6) {
                          return "pasword is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.signUp(
                            userNameController.text,
                            emailcontroller.text,
                            passordcontroller.text,
                          );
                        }
                      },
                      title: 'Sign Up',
                    ),

                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
