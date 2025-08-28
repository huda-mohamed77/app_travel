import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/core/colors_style.dart';

class PlaceCard extends StatefulWidget {
  const PlaceCard({super.key});

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  bool isFavourite = false;

  Future<void> _addToFavourites() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please log in first")),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favourites')
          .add({
        'name': 'Mount Fuji',
        'location': 'Tokyo, Japan',
        'image': 'assets/download (29) 1.png', 
      });

      setState(() {
        isFavourite = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Added to favourites")),
      );
    } catch (e) {
      print("❌ Error adding to favourites: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Something went wrong")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 300,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.asset(
              'assets/download (29) 1.png',
              fit: BoxFit.cover,
            ),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [ColorsStyle.tenColor, Colors.transparent],
                ),
              ),
            ),

            // Favorite button
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: isFavourite ? null : _addToFavourites,
                child: CircleAvatar(
                  backgroundColor: ColorsStyle.sevenColor.withOpacity(0.6),
                  child: Icon(
                    isFavourite ? Icons.favorite : Icons.favorite_border,
                    color: ColorsStyle.primaryColor,
                  ),
                ),
              ),
            ),

            // Info text
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mount Fuji, Tokyo',
                    style: TextStyle(
                      color: ColorsStyle.eightColor,
                      fontWeight: FontWeight.w200,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          color: ColorsStyle.nineColor, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        'Tokyo, Japan',
                        style: TextStyle(
                            color: ColorsStyle.nineColor, fontSize: 12),
                      ),
                      const Spacer(),
                      const Icon(Icons.star_border_outlined, size: 14),
                      const SizedBox(width: 2),
                      Text(
                        '4.8',
                        style: TextStyle(
                            color: ColorsStyle.nineColor, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
