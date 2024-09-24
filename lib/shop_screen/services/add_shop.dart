import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../auth/sign_in/hive/token_storage.dart';

final Dio _dio = Dio();
final String url = dotenv.env['URL'] ?? '';
Future<bool> addNewShopService({
  required String shopName,
  required String shopAddress,
  required String shopRegNo,
  required String shopContact,
}) async {
  try {
    // Get access token
    String? accessToken = await TokenStorage.getAccessToken();

    if (accessToken != null) {
      // Decode the access token to get the user ID
      Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
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

      // Send the request to create a new shop
      final response = await _dio.post(
        '$url/shops',
        data: shopData,
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      if (response.statusCode == 201) {
        return true; // Success
      } else {
        return false; // Failure with status code
      }
    } else {
      return false; // No access token found
    }
  } catch (e) {
    throw Exception('Error creating shop: $e');
  }
}
