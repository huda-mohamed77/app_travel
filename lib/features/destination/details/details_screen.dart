import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/core/colors_style.dart';

import 'package:travel_app/features/auth/models/user_model.dart';

import 'package:travel_app/features/destination/cubit/destination_cubit.dart';
import 'package:travel_app/features/destination/cubit/destination_state.dart';
import 'package:travel_app/features/destination/models/destination_model.dart';
// import 'package:travel_app/features/auth/models/user_model.dart';

class DetailScreen extends StatelessWidget {
  final DestinationModel place;
    final AppUser user;

  const DetailScreen({super.key, required this.place, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE1E9F4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    Image.network(
                      place.imageUrl,
                      height:
                          MediaQuery.of(context).size.height *
                          0.65, 
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned.fill(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.black],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 12,
                      right: 12,
                      bottom: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    place.title,
                                    style: const TextStyle(
                                      color: ColorsStyle.primaryColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w600,
                                      shadows: [
                                        Shadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 2,
                                          color: ColorsStyle.thrtineeColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        size: 24,
                                        color: Colors.white30,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        place.location,
                                        style: const TextStyle(
                                          color: ColorsStyle.sixColor,
                                          fontSize: 12,
                                          height: 1,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(0, 1),
                                              blurRadius: 2,
                                              color: ColorsStyle.thrtineeColor,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                 Text(
                                  'Price',
                                  style: TextStyle(
                                    color: ColorsStyle.secondColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(0, 1),
                                        blurRadius: 2,
                                        color: ColorsStyle.thrtineeColor,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '\$${place.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: ColorsStyle.primaryColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    shadows: [
                                      Shadow(
                                        offset: Offset(0, 1),
                                        blurRadius: 2,
                                        color: ColorsStyle.thrtineeColor,
                                      ),
                                    ],
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
              const SizedBox(height: 14),

              Row(
                children: const [
                  Text(
                    'Overview',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,color: ColorsStyle.thrtineeColor),
                  ),
                  SizedBox(width: 14),
                  Text(
                    'Details',
                    style: TextStyle(fontSize: 14, color: ColorsStyle.thrtineeColor),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  _IconBox(icon: Icons.access_time,),
                  const SizedBox(width: 10),
                  Text(
                    place.duration,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: ColorsStyle.thrtineeColor
                    ),
                  ),
                  const SizedBox(width: 20),
                  _IconBox(icon: Icons.cloud),
                  const SizedBox(width: 10),
                  Text(
                    place.temperature,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: ColorsStyle.thrtineeColor
                    ),
                  ),
                  const SizedBox(width: 20),
                  _IconBox(icon: Icons.star),
                  const SizedBox(width: 10),
                  Text(
                    place.rating.toString(),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: ColorsStyle.thrtineeColor
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Text(
                place.description,
                style: const TextStyle(fontSize: 13, color: ColorsStyle.sevenColor,fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              BlocConsumer<BookingCubit, BookingState>(
                listener: (context, state) {
                  if (state is BookingSuccess) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Booking Confirmed ✅",style: TextStyle(color: ColorsStyle.thrtineeColor)),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Trip: ${place.title}",style: TextStyle(color: ColorsStyle.thrtineeColor)),
                            const SizedBox(height: 6),
                            Text(
                              "Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",style: TextStyle(color: ColorsStyle.thrtineeColor),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Time: ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",style: TextStyle(color: ColorsStyle.thrtineeColor)
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              "Your booking has been successfully recorded 🎉",
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("OK",style: TextStyle(color: ColorsStyle.thrtineeColor),),
                          ),
                        ],
                      ),
                    );
                  } else if (state is BookingError) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Booking Failed ❌",style: TextStyle(color: ColorsStyle.thrtineeColor)),
                        content: Text(state.message),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("OK",style: TextStyle(color: ColorsStyle.thrtineeColor)),
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
                      backgroundColor: ColorsStyle.thrtineeColor,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                         mainAxisSize: MainAxisSize.max,
                      children: const [
                        Text(
                          'Book Now',
                          style: TextStyle(
                            color: ColorsStyle.primaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 12),
                        Icon(Icons.send_sharp, color: ColorsStyle.primaryColor, size: 30),
                      ],
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

class _IconBox extends StatelessWidget {
  final IconData icon;
  const _IconBox({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorsStyle.fourteenColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 18, color: ColorsStyle.thrtineeColor),
    );
  }
}
