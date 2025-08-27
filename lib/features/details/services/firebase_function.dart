import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/booking_model.dart';

class FirebaseService {
  final CollectionReference bookingsCollection =
      FirebaseFirestore.instance.collection('bookings');

  Future<void> bookTrip(Booking booking) async {
    await bookingsCollection.doc(booking.id).set(booking.toJson());
  }

  Future<List<Booking>> getBookings() async {
    final snapshot = await bookingsCollection.get();
    return snapshot.docs
        .map((doc) => Booking.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<void> deleteBooking(String id) async {
    await bookingsCollection.doc(id).delete();
  }
}