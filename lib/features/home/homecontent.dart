import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/colors_style.dart';
import 'package:travel_app/features/auth/cubit/auth_logic.dart';
import 'package:travel_app/features/auth/cubit/auth_state.dart';
import 'package:travel_app/features/destination/widgets/card.dart';
import 'package:travel_app/features/destination/widgets/card2.dart';

class HomeContentPage extends StatefulWidget {
  const HomeContentPage({super.key});

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  final TextEditingController _searchController = TextEditingController();


  final List<Map<String, dynamic>> allPlaces = [
    {
      'name': 'Mount Fuji',
      'location': 'Tokyo, Japan',
      'widget': const PlaceCard(),
    },
    {
      'name': 'Andes Mountain',
      'location': 'South America',
      'widget': const AndesCard(),
    },
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredPlaces = allPlaces.where((place) {
      final name = place['name'].toString().toLowerCase();
      final location = place['location'].toString().toLowerCase();
      return name.contains(_searchQuery.toLowerCase()) ||
          location.contains(_searchQuery.toLowerCase());
    }).toList();

    return SafeArea(
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
            return  Center(child: CircularProgressIndicator());
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
               SizedBox(height: 4),
                Text(
                  'Explore the world',
                  style: TextStyle(
                    color: ColorsStyle.secondColor,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                 SizedBox(height: 30),

                // Search Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: ColorsStyle.primaryColor,
                    border: Border.all(color: ColorsStyle.secondColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                           style: TextStyle(color: ColorsStyle.thrtineeColor,fontWeight: FontWeight.bold),
                            cursorColor: ColorsStyle.thrtineeColor,
                          decoration:  InputDecoration(
                            hintText: 'Search places',
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                        ),
                      ),
                      Icon(Icons.tune, color: ColorsStyle.secondColor),
                    ],
                  ),
                ),

                 SizedBox(height: 50),

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

                 SizedBox(height: 50),

                // Places List
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: filteredPlaces.map((place) {
                      return Row(
                        children: [
                          place['widget'],
                        SizedBox(width: 16),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


