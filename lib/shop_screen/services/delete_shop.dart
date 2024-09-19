import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final Dio _dio = Dio();
String url = dotenv.env['URL'] ?? '';

Future<bool> deleteShop(int shopId) async {
  try {
    url = '$url/shops?shopId=$shopId';

    final response = await _dio.delete(url);

    return response.statusCode == 200;
  } catch (e) {
    return false;
  }
}
