import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../model/sign_in_response_model.dart';

class SignInService {
  final Dio _dio = Dio();
  final String url = dotenv.env['URL'] ?? '';

  Future<SignInResponseModel?> signInUser(String email, String password) async {
    try {
      String uri = '$url/auth/sign-in';
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
      debugPrint(error.toString());
      throw Exception("Internal Server Error: $error");
    }
  }
}
