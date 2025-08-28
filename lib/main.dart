import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/dp/firebase_fun.dart';
import 'package:travel_app/features/auth/cubit/auth_logic.dart';
import 'package:travel_app/features/auth/models/user_model.dart';
import 'features/details/details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyPlace = PlaceModel(
      id: '1',
      name: 'Andes Mountain',
      location: 'South America',
      price: 230,
      image: 'assets/mountain.png',
      description:
          'This vast mountain range is renowned for its remarkable diversity in terms of topography and climate.',
    );

    final dummyUser = AppUser(
      id: 'user123',
      name: 'Divad',
      email: 'divad@example.com',
      favorites: [],
    );

    return BlocProvider(
      create: (_) => DetailsCubit(FirebaseFunctions()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Travel App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: DetailScreen(place: dummyPlace, user: dummyUser),
      ),
    );
  }
}
