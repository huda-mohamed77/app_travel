import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:travel_app/core/dp/firebase_fun.dart';
import 'package:travel_app/features/auth/cubit/auth_state.dart';
import 'package:travel_app/features/auth/models/user_model.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseFunctions _firebaseFunctions;

  AuthCubit(this._firebaseFunctions) : super(AuthInitial());

  // SignUp
  Future<void> signUp(String name, String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _firebaseFunctions.signUp(name, email, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // Login
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final user = await _firebaseFunctions.login(email, password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // Logout
  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await _firebaseFunctions.logout();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  }
class DetailsCubit extends Cubit<DetailsState> {
  final FirebaseFunctions service;
  DetailsCubit(this.service) : super(DetailsInitial());

  Future<void> bookTrip(PlaceModel place, AppUser user) async {
    emit(BookingLoading());
    try {
      final booking = Booking(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: user.id,
        dateTime: DateTime.now(),
        place: place,
      );
      await service.bookTrip(booking);
      emit(BookingSuccess());
    } catch (e) {
      emit(BookingError(e.toString()));
=======
  Future<void> updateProfile({String? name, String? email}) async {
    emit(AuthLoading());
    try {
      await _firebaseFunctions.updateProfile(name: name, email: email);
      
    
      final updatedUser = await _firebaseFunctions.getCurrentUser();
      if (updatedUser != null) {
        emit(AuthSuccess(updatedUser));
      } else {
        emit(AuthFailure("User not found after update"));
      }
    } catch (e) {
      emit(AuthFailure("Failed to update profile: $e"));
    }
  }
}

