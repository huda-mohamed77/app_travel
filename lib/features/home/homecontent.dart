import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/colors_style.dart';
import 'package:travel_app/features/auth/cubit/auth_logic.dart';
import 'package:travel_app/features/auth/cubit/auth_state.dart';
import 'package:travel_app/features/destination/details/details_screen.dart';

import 'package:travel_app/features/destination/widgets/card.dart';
// import 'package:travel_app/features/destination/widgets/card2.dart';

import 'package:travel_app/features/destination/models/destination_model.dart';

class HomeContentPage extends StatefulWidget {
  const HomeContentPage({super.key});

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
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
                /// Greeting
                Row(
                  children: [
                    Text(
                      state is AuthSuccess
                          ? 'Hi, ${state.user.name}'
                          : 'Hi, Guest',
                      style: TextStyle(
                        color: ColorsStyle.thrtineeColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text('👋', style: TextStyle(fontSize: 20)),
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

                /// Search Bar
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
                          style: TextStyle(
                            color: ColorsStyle.thrtineeColor,
                            fontWeight: FontWeight.bold,
                          ),
                          cursorColor: ColorsStyle.thrtineeColor,
                          decoration: const InputDecoration(
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

                const SizedBox(height: 50),

                /// Section title
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

                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('places')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("No destinations found"));
                    }

                    // Convert snapshot to List<DestinationModel>
                    final destinations = snapshot.data!.docs
                        .map(
                          (doc) => DestinationModel.fromJson(
                            doc.data() as Map<String, dynamic>,
                            doc.id,
                          ),
                        )
                        .where((place) {
                          // Apply search filter
                          final name = place.title.toLowerCase();
                          final location = place.location.toLowerCase();
                          return name.contains(_searchQuery.toLowerCase()) ||
                              location.contains(_searchQuery.toLowerCase());
                        })
                        .toList();

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: destinations.map((place) {
                          return Row(
                            children: [
                              PlaceCard(
                                place: place,

                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          DetailScreen(place: place),
                                    ),
                                  );
                                },
                                user: null,
                              ),
                              const SizedBox(width: 16),
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
