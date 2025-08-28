import 'package:flutter/material.dart';
import 'package:travel_app/core/colors_style.dart';
import 'package:travel_app/features/home/favourite.dart';
import 'package:travel_app/features/home/homecontent.dart';
import 'package:travel_app/features/home/profile.dart';
import 'package:travel_app/features/home/timeout.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeContentPage(),
    TimePage(), 
    FavouritesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorsStyle.primaryColor,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorsStyle.thrtineeColor,
        unselectedItemColor: ColorsStyle.secondColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 5,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items:  [
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




