class DestinationModel {
  final String id;
  final String title;
  final String location;
  final double price;
  final String imageUrl;
  final double rating;
  final String duration;
  final String temperature;
  final String description;

  DestinationModel({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.duration,
    required this.temperature,
    required this.description,
  });

  factory DestinationModel.fromJson(Map<String, dynamic> json, String docId) {
    return DestinationModel(
      id: docId,
      title: json['title'] ?? '',
      location: json['location'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      duration: json['duration'] ?? '',
      temperature: json['temperature'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'location': location,
      'price': price,
      'imageUrl': imageUrl,
      'rating': rating,
      'duration': duration,
      'temperature': temperature,
      'description': description,
    };
  }
}
