class AppUser {
  final String id;
  final String email;
  final String name;
  final List<dynamic> favorites;

  AppUser({
    required this.id,
    required this.email,
    required this.name,
    required this.favorites,
  });

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name, 'favorites': favorites};
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      favorites: json['favorites'] ?? [],
    );
  }
}
// details Model
class Booking {
  final String id;
  final String userId;
  final DateTime dateTime;
  final PlaceModel place;

  Booking({
    required this.id,
    required this.userId,
    required this.dateTime,
    required this.place,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'dateTime': dateTime.toIso8601String(),
      'place': place.toJson(),
    };
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      userId: json['userId'],
      dateTime: DateTime.parse(json['dateTime']),
      place: PlaceModel.fromJson(json['place']),
    );
  }
}

class PlaceModel {
  final String id;
  final String name;
  final String location;
  final double price;
  final String image;
  final String description;

  PlaceModel({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.image,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'price': price,
      'image': image,
      'description': description,
    };
  }

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      description: json['description'],
    );
  }
}

