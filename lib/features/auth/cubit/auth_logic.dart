import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:travel_app/core/dp/firebase_fun.dart';
import 'package:travel_app/features/auth/cubit/auth_state.dart';

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
