import 'package:flutter/material.dart';
import 'package:travel_app/core/colors_style.dart';
import 'package:travel_app/core/dp/firebase_fun.dart';


class AndesCard extends StatefulWidget {
  const AndesCard({super.key});

  @override
  State<AndesCard> createState() => _AndesCardState();
}

class _AndesCardState extends State<AndesCard> {
  bool isFavourite = false;

  Future<void> _addToFavourites() async {
    try {
      await FirebaseFunctions().addToFavorites({
        'name': 'Andes Mountain',
        'location': 'South America',
        'image': 'assets/download (30) 2.png',
      });

      setState(() {
        isFavourite = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Added to favourites")),
      );
    } catch (e) {
      print("❌ Error: $e");
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
            // 🔁 استخدمي صورة من الإنترنت
            Image.asset(
              'assets/download (30) 2.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
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

            // ❤️ Favorite Button
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

            // Info
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Andes, South',
                    style: TextStyle(
                      color: ColorsStyle.eightColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: ColorsStyle.nineColor,
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'South America',
                        style: TextStyle(
                          color: ColorsStyle.nineColor,
                          fontSize: 12,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.star_border_outlined, size: 14),
                      SizedBox(width: 2),
                      Text(
                        '4.7',
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


