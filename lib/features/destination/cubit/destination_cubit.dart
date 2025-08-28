import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/features/destination/cubit/destination_state.dart';
import 'package:travel_app/features/destination/models/destination_model.dart';
import 'package:travel_app/features/auth/models/user_model.dart';

class BookingCubit extends Cubit<BookingState> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  BookingCubit(destinationService) : super(BookingInitial());

  Future<void> bookPlace(DestinationModel place, AppUser user) async {
    emit(BookingLoading());
    try {
      final now = DateTime.now();
      final bookingData = {
        'userId': user.id,
        'placeId': place.id,
        'placeName': place.title,
        'price': place.price,
        'date': "${now.day}/${now.month}/${now.year}",
        'time': "${now.hour}:${now.minute.toString().padLeft(2, '0')}",
        'createdAt': now,
      };

      await firestore.collection('bookings').add(bookingData);

      emit(BookingSuccess());
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }
}
