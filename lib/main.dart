import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/dp/firebase_fun.dart';
import 'package:travel_app/features/auth/cubit/auth_logic.dart';
import 'package:travel_app/features/splash/splash_screen.dart';

import 'package:travel_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(FirebaseFunctions())),
        BlocProvider(create: (context) => DetailsCubit(FirebaseFunctions())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),

        //    isLoggedIn ? HomeScreen() : SignupScreen(),
      ),
    );
  }
}
