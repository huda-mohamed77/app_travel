abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class BookingLoading extends DetailsState {}

class BookingSuccess extends DetailsState {}

class BookingError extends DetailsState {
  final String message;
  BookingError(this.message);
}

