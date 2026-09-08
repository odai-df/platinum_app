import 'package:platinum_app/core/networking/api_error_handler.dart';
import 'package:platinum_app/core/networking/api_result.dart';
import 'package:platinum_app/core/networking/api_service.dart';

import '../models/appointment_model.dart';
import '../models/available_slot_model.dart';
import '../models/cancel_appointment_response.dart';
import '../models/create_appointment_request.dart';
import '../models/create_appointment_response.dart';

class AppointmentRepo {
  final ApiService _apiService;

  AppointmentRepo(this._apiService);

  Future<ApiResult<List<AppointmentModel>>> getMyAppointments() async {
    try {
      final response = await _apiService.getMyAppointments();

      return ApiResult.success(
        response.data ?? [],
      );
    } catch (e, stack) {
      print("🔥 GET MY APPOINTMENTS ERROR:");
      print(e);
      print("📌 STACK:");
      print(stack);

      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }

  Future<ApiResult<List<AvailableSlotModel>>> getAvailableSlots() async {
    try {
      final response = await _apiService.getAvailableSlots();

      return ApiResult.success(response.data);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }

  Future<ApiResult<CreateAppointmentData>> createAppointment(
      CreateAppointmentRequest request,
      ) async {
    try {
      final response = await _apiService.createAppointment(
        request.toMap(),
      );

      return ApiResult.success(response.data);
    } catch (e) {
      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }

  Future<ApiResult<CancelAppointmentResponse>> cancelAppointment(
      int appointmentId,
      ) async {
    try {
      final response = await _apiService.cancelAppointment(
        appointmentId,
      );

      return ApiResult.success(response);
    } catch (e, stack) {
      print("🔥 CANCEL APPOINTMENT ERROR:");
      print(e);
      print(stack);

      return ApiResult.failure(
        ErrorHandler.handle(e),
      );
    }
  }


}