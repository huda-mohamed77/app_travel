import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/colors_style.dart';
import 'package:travel_app/features/auth/cubit/auth_logic.dart';
import 'package:travel_app/features/auth/cubit/auth_state.dart';
import 'package:travel_app/features/auth/widget/card.dart';
import 'package:travel_app/features/auth/widget/card2.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Welcome, ${state.user.name}!')),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        state is AuthSuccess ? 'Hi, ${state.user.name}' : 'Hi, Guest',
                        style: TextStyle(
                          color: ColorsStyle.thrtineeColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('👋', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Explore the world',
                    style: TextStyle(
                      color: ColorsStyle.secondColor,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: ColorsStyle.primaryColor,
                      border: Border.all(color: ColorsStyle.secondColor),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search places',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(Icons.tune, color: ColorsStyle.secondColor),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Popular places',
                        style: TextStyle(
                          color: ColorsStyle.thrtineeColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'View all',
                        style: TextStyle(
                          color: ColorsStyle.secondColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: const [
                        PlaceCard(),
                        SizedBox(width: 16),
                        AndesCard(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorsStyle.primaryColor,
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorsStyle.thrtineeColor,
        unselectedItemColor: ColorsStyle.secondColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 5,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, size: 28),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time, size: 26),
            label: 'Time',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border, size: 26),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 26),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}


