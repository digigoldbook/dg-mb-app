import 'package:dio/dio.dart';

import '../../../components/utils/app_service.dart';

class ResetPasswordService {
  final HttpService service = HttpService();

  Future<bool> checkUserExistince({Map<String, dynamic>? params}) async {
    try {
      final response = await service.put(
        "/users/profile-details",
        params: params,
      );

      return response.statusCode == 200;
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> resetPassword({
    Map<String, dynamic>? params,
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await service.put(
        "/users/reset-password",
        params: params,
        data: data,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
