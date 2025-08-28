import 'package:travel_app/features/auth/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AppUser user;

  AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}

//details states
abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class BookingLoading extends DetailsState {}

class BookingSuccess extends DetailsState {}

class BookingError extends DetailsState {
  final String message;
  BookingError(this.message);
}

=======
class AuthLoggedOut extends AuthState {} 

