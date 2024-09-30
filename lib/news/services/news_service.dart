import 'package:dio/dio.dart';

import '../../components/utils/app_service.dart';

class NewsService {
  final HttpService _httpService = HttpService();
  Future<Response> fetchNews() async {
    try {
      final response = await _httpService
          .get("https://arthasarokar.com/wp-json/wp/v2/posts?_embed");

      return response;
    } catch (error) {
      throw "Error: $error";
    }
  }
}
