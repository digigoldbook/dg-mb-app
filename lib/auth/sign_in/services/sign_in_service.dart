import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/sign_in_response_model.dart';

class SignInService {
  final Dio _dio = Dio();
  final String url = dotenv.env['URL'] ?? 'http://192.168.1.87:3000/api';

  Future<SignInResponseModel?> signInUser(String email, String password) async {
    try {
      String uri = '$url/v1/auth/sign-in';
      var data = {
        "email": email,
        "password": password,
      };
      Response response = await _dio.post(uri, data: data);

      if (response.statusCode == 200) {
        final signInResponse = SignInResponseModel.fromJson(response.data);
        return signInResponse;
      } else {
        return null;
      }
    } catch (error) {
      throw Exception("Internal Server Error: $error");
    }
  }
}
