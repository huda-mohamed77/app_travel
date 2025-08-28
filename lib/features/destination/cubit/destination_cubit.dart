import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/features/destination/cubit/destination_state.dart';
import 'package:travel_app/features/destination/database/destination_service.dart';
import 'package:travel_app/features/destination/models/destination_model.dart';

class DestinationCubit extends Cubit<DestinationState> {
  final DestinationService service;

  DestinationCubit(this.service) : super(DestinationInitial());

  // جلب البيانات
  Future<void> fetchDestinations() async {
    try {
      emit(DestinationLoading());
      final destinations = await service.getDestinations();
      emit(DestinationLoaded(destinations));
    } catch (e) {
      emit(DestinationError(e.toString()));
    }
  }

  // إضافة مكان
  Future<void> addDestination(DestinationModel destination) async {
    try {
      await service.addDestination(destination);
      fetchDestinations(); // نعيد الجلب بعد الإضافة
    } catch (e) {
      emit(DestinationError(e.toString()));
    }
  }

  // تعديل
  Future<void> updateDestination(
    String id,
    DestinationModel destination,
  ) async {
    try {
      await service.updateDestination(id, destination);
      fetchDestinations();
    } catch (e) {
      emit(DestinationError(e.toString()));
    }
  }

  // مسح
  Future<void> deleteDestination(String id) async {
    try {
      await service.deleteDestination(id);
      fetchDestinations();
    } catch (e) {
      emit(DestinationError(e.toString()));
    }
  }
}
