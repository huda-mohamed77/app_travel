import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:travel_app/features/auth/models/user_model.dart';
import 'package:travel_app/features/destination/cubit/destination_cubit.dart';
import 'package:travel_app/features/destination/cubit/destination_state.dart';
import 'package:travel_app/features/destination/models/destination_model.dart';

class DetailScreen extends StatelessWidget {
  final DestinationModel place;
  final AppUser user;

  const DetailScreen({super.key, required this.place, required this.user});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFE1E9F4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // صورة المكان
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    Image.asset(
                      place.imageUrl,
                      height: height * 0.65,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.35),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: width * 0.03,
                      right: width * 0.03,
                      bottom: width * 0.03,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.03,
                          vertical: height * 0.012,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    place.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.055,
                                      fontWeight: FontWeight.w600,
                                      shadows: const [
                                        Shadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 2,
                                          color: Colors.black26,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: height * 0.008),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: width * 0.05,
                                        color: Colors.white30,
                                      ),
                                      SizedBox(width: width * 0.01),
                                      Text(
                                        place.location,
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: width * 0.035,
                                          shadows: const [
                                            Shadow(
                                              offset: Offset(0, 1),
                                              blurRadius: 2,
                                              color: Colors.black26,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  'Price',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: height * 0.005),
                                Text(
                                  '\$${place.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.055,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: height * 0.02),
              Text(
                'Overview',
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: height * 0.02),
              Text(
                place.description,
                style: TextStyle(fontSize: width * 0.035, color: Colors.grey),
              ),
              SizedBox(height: height * 0.02),

              BlocConsumer<BookingCubit, BookingState>(
                listener: (context, state) {
                  if (state is BookingSuccess) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Booking Confirmed ✅"),
                        content: const Text(
                          "Your booking has been successfully recorded 🎉",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );
                  } else if (state is BookingError) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Booking Failed ❌"),
                        content: Text(state.message),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () {
                      context.read<BookingCubit>().bookPlace(place, user);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: height * 0.02),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      "Book Now",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
