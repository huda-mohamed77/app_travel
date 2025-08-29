import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/core/colors_style.dart';
import 'package:travel_app/features/auth/models/user_model.dart';
import 'package:travel_app/features/destination/models/destination_model.dart';

class PlaceCard extends StatefulWidget {
  final DestinationModel place;
  final AppUser? user;
  final VoidCallback onTap;

  const PlaceCard({
    super.key,
    required this.place,
    required this.user,
    required this.onTap,
  });

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavourite();
  }

  // ✅ تحقق من إذا كان المكان بالفعل في المفضلة
  Future<void> _checkIfFavourite() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('favourites')
        .doc(widget.place.id)
        .get();

    if (mounted) {
      setState(() {
        isFavourite = doc.exists;
      });
    }
  }

  // ✅ إضافة المكان للمفضلة
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

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("✅ Added to favourites")));
    } catch (e) {
      print("❌ Error adding to favourites: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: SizedBox(
        width: 180,
        height: 300,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image with placeholder
              Image.network(
                (widget.place.imageUrl.isNotEmpty &&
                        (widget.place.imageUrl.startsWith('http') ||
                            widget.place.imageUrl.startsWith('https')))
                    ? widget.place.imageUrl
                    : 'https://via.placeholder.com/180x300',
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.image_not_supported,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),

              // Gradient overlay
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
                      widget.place.title,
                      style: TextStyle(
                        color: ColorsStyle.eightColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
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
      ),
    );
  }
}
