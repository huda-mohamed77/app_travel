import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/core/colors_style.dart';
import 'package:travel_app/features/auth/models/user_model.dart';
import 'package:travel_app/features/destination/models/destination_model.dart';

class AndesCard extends StatefulWidget {
  final DestinationModel place;
  final AppUser? user;

  const AndesCard({super.key, required this.place, this.user});

  @override
  State<AndesCard> createState() => _AndesCardState();
}

class _AndesCardState extends State<AndesCard> {
  bool isFavourite = false;

  Future<void> _addToFavourites() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('favourites')
          .doc(widget.place.id);

      final snapshot = await docRef.get();
      if (snapshot.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Already added to favourites")),
        );
        return;
      }

      await docRef.set(widget.place.toJson());

      setState(() {
        isFavourite = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Added to favourites")),
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
            // صورة من Firebase
            Image.network(
              widget.place.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image),
            ),

            // طبقة تظليل
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [ColorsStyle.tenColor, Colors.transparent],
                ),
              ),
            ),

            // زرار ❤️
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

            // المعلومات
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.place.title,
                    style: TextStyle(
                      color: ColorsStyle.eightColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: ColorsStyle.nineColor,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.place.location,
                        style: TextStyle(
                          color: ColorsStyle.nineColor,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.star_border_outlined, size: 14),
                      const SizedBox(width: 2),
                      Text(
                        widget.place.rating.toString(),
                        style: TextStyle(
                          color: ColorsStyle.nineColor,
                          fontSize: 12,
                        ),
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


