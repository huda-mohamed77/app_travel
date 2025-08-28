import 'package:flutter/material.dart';
import 'package:travel_app/core/colors_style.dart';
import 'package:travel_app/core/dp/firebase_fun.dart';
 

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  final FirebaseFunctions firebaseFunctions = FirebaseFunctions();

  List<Map<String, dynamic>> favourites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavourites();
  }

  Future<void> _loadFavourites() async {
    setState(() {
      isLoading = true;
    });

    final favs = await firebaseFunctions.getUserFavorites();

    setState(() {
      favourites = favs;
      isLoading = false;
    });
  }

  Future<void> _removeFavourite(String docId) async {
    await firebaseFunctions.removeFromFavorites(docId);
    _loadFavourites(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsStyle.thrtineeColor,
        title: Text(
          '❤️ Favourites',
          style: TextStyle(color: ColorsStyle.primaryColor),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : favourites.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border,
                          size: 100, color: ColorsStyle.secondColor),
                      SizedBox(height: 16),
                      Text(
                        'No favourites yet',
                        style: TextStyle(color: ColorsStyle.thrtineeColor),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        child: Text('Explore Places',
                            style: TextStyle(color: ColorsStyle.thrtineeColor)),
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
                        leading: place['image'] != null
                            ? Image.network(
                                place['image'],
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              )
                            : null,
                        title: Text(place['name'] ?? '',
                            style: TextStyle(color: ColorsStyle.primaryColor)),
                        subtitle: Text(place['location'] ?? '',
                            style: TextStyle(color: ColorsStyle.primaryColor)),
                        trailing: IconButton(
                          icon: Icon(Icons.favorite, color: ColorsStyle.twlveColor),
                          onPressed: () => _removeFavourite(place['id']),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}


