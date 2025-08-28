
import 'package:flutter/material.dart';
import 'package:travel_app/core/colors_style.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    
    final favourites = [
    
      {'name': 'Mount Fuji', 'location': 'Tokyo, Japan', 'image': 'assets/download (29) 1.png'},
      {'name': 'Andes Mountain', 'location': 'South America', 'image': 'assets/download (30) 2.png'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsStyle.thrtineeColor,
        title:Text('❤️ Favourites',style: TextStyle(color: ColorsStyle.primaryColor)),
        centerTitle: true,
      ),
      body: favourites.isEmpty
          ? Center(
          
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Icon(Icons.favorite_border, size: 100, color: ColorsStyle.secondColor),
                SizedBox(height: 16),
                  Text('No favourites yet',style: TextStyle(color: ColorsStyle.thrtineeColor),),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                  
                    },
                    child:Text('Explore Places',style: TextStyle(color: ColorsStyle.thrtineeColor)),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemCount: favourites.length,
              itemBuilder: (context, index) {
                final place = favourites[index];
                return Card(
                  
                  margin: const EdgeInsets.all(10),
                  color: ColorsStyle.thrtineeColor,
                  child: ListTile(
                    leading: Image.network(place['image']!, width: 60, fit: BoxFit.cover),
                    title: Text(place['name']!,style: TextStyle(color: ColorsStyle.primaryColor),),
                    subtitle: Text(place['location']!,style: TextStyle(color: ColorsStyle.primaryColor),),
                    trailing: IconButton(
                      icon:Icon(Icons.favorite, color: ColorsStyle.twlveColor),
                      onPressed: () {
                        // remove from favourites logic
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
