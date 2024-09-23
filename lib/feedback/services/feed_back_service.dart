import 'package:dio/dio.dart';

import '../../components/utils/app_service.dart';

class FeedBackService {
  HttpService httpService = HttpService();
  Future<Response> sendFeedback({Map<String, dynamic>? data}) async {
    try {
      final respose = await httpService.post(
        "/feedback",
        data: data,
      );
      return respose;
    } catch (error) {
      throw "$error";
    }
  }
}
