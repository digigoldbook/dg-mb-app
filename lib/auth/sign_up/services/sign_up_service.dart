import 'package:dio/dio.dart';

import '../../../components/utils/app_service.dart';

Future<Response> signUpService({Map<String, dynamic>? data}) async {
  final HttpService httpService = HttpService();
  try {
    final response = await httpService.post("/auth/sign-up", data: data);

    return response;
  } catch (error) {
    throw 'Server Error: $error';
  }
}
