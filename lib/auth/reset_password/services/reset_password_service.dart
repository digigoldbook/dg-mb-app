import 'package:dio/dio.dart';

import '../../../components/utils/app_service.dart';

Future<Response> resetPasswordService({
  Map<String, dynamic>? params,
  Map<String, dynamic>? data,
}) async {
  final HttpService service = HttpService();
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
