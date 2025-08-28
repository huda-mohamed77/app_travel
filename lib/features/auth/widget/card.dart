import 'package:flutter/material.dart';
import 'package:travel_app/core/colors_style.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
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

        
            Positioned(
              top: 8,
              right: 8,
              child: CircleAvatar(
                // ignore: deprecated_member_use
                backgroundColor: ColorsStyle.sevenColor.withOpacity(0.6),
                child: Icon(Icons.favorite_border, color: ColorsStyle.primaryColor),
              ),
            ),

          
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
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: ColorsStyle.nineColor, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'Tokyo, Japan',
                        style: TextStyle(color: ColorsStyle.nineColor, fontSize: 12),
                      ),
                      Spacer(),
                      Icon(Icons.star_border_outlined, size: 14,),
                      SizedBox(width: 2),
                      Text(
                        '4.8',
                        style: TextStyle(color: ColorsStyle.nineColor, fontSize: 12),
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