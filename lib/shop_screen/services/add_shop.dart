import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../auth/sign_in/hive/token_storage.dart';
import '../../components/utils/app_service.dart';

final HttpService _httpService = HttpService();
Future<Response> addNewShopService({
  required String shopName,
  required String shopAddress,
  required String shopRegNo,
  required String shopContact,
}) async {
  try {
    String? accessToken = await TokenStorage.getAccessToken();

    Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken!);
    int userId = decodedToken['userId'];

    // Prepare data for the new shop
    Map<String, dynamic> shopData = {
      "shop_name": shopName,
      "shop_address": shopAddress,
      "shop_reg_no": shopRegNo,
      "shop_contact": shopContact,
      "meta": [
        {
          "meta_key": "owner",
          "meta_value": userId,
        }
      ]
    };

    final Response response = await _httpService.post(
      "/shops",
      data: shopData,
    );

    return response;
  } catch (e) {
    throw Exception('Error creating shop: $e');
  }
}
