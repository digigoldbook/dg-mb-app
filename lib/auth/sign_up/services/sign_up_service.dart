import 'package:dio/dio.dart';

import '../../../components/utils/app_service.dart';

Future<Response> signUpService({Map<String, dynamic>? data}) async {
  final HttpService httpService = HttpService();

  try {
    final response = await httpService.post("/auth/sign-up", data: data);
    return response;
  } on DioException catch (error) {
    if (error.response != null) {
      final errorMessage =
          error.response?.data['message'] ?? 'Unknown error occurred';
      throw Exception("Sign-up Failed: $errorMessage");
    } else {
      throw Exception("Connection Error: ${error.message}");
    }
  } catch (error) {
    // Handling other errors
    throw Exception("Server Error: $error");
  }
}
