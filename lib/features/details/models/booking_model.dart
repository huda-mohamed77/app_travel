class Booking {
  final String id;
  final String placeName;
  final String userId;
  final DateTime dateTime;

  Booking({
    required this.id,
    required this.placeName,
    required this.userId,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'placeName': placeName,
      'userId': userId,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      placeName: json['placeName'],
      userId: json['userId'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }
}