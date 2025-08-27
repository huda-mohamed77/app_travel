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