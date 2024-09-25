import 'package:dio/dio.dart';

import '../../../components/utils/app_service.dart';
import '../model/sign_in_response_model.dart';

class SignInService {
  final HttpService _httpService = HttpService();

  Future<SignInResponseModel?> signInUser(String email, String password) async {
    try {
      final data = {
        "email": email,
        "password": password,
      };
      Response response = await _httpService.post("/auth/sign-in", data: data);

      if (response.statusCode == 200) {
        final signInResponse = SignInResponseModel.fromJson(response.data);
        return signInResponse;
      } else {
        return null;
      }
    } on DioException catch (error) {
      if (error.response != null) {
        final errorMessage =
            error.response?.data['message'] ?? 'Unknown error occurred';
        throw Exception("$errorMessage");
      } else {
        // Error without a response (like no internet, request timeout, etc.)
        throw Exception("Connection Error: ${error.message}");
      }
    } catch (error) {
      // Handling other errors
      throw Exception("Internal Server Error: $error");
    }
  }
}
