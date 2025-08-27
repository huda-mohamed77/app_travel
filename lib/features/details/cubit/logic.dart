import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/features/details/cubit/states.dart';
import 'package:travel_app/features/details/models/booking_model.dart';
import 'package:travel_app/features/details/services/firebase_function.dart';

class DetailsCubit extends Cubit<DetailsState> {
  final FirebaseService service;
  DetailsCubit(this.service) : super(DetailsInitial());

  Future<void> bookTrip(String placeName, String userId) async {
    emit(BookingLoading());
    try {
      final booking = Booking(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        placeName: placeName,
        userId: userId,
        dateTime: DateTime.now(),
      );
      await service.bookTrip(booking);
      emit(BookingSuccess());
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }
}