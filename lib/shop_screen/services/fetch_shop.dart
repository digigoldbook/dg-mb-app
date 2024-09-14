import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../auth/sign_in/hive/token_storage.dart';
import '../model/shop_model.dart';

final Dio _dio = Dio();
final String url = dotenv.env['URL'] ?? "";
const String _hiveBoxName = 'shopBox';

class FetchShopService {
  Future<ShopModel?> getShops({int? page}) async {
    try {
      // Get access token
      String? accessToken = await TokenStorage.getAccessToken();

      if (accessToken != null) {
        _dio.options.headers['Authorization'] = 'Bearer $accessToken';
      }

      // Fetch shops from Hive storage first
      final shopsFromHive = await _getShopsFromHive();
      if (shopsFromHive != null && shopsFromHive.shopData != null) {
        return shopsFromHive;
      }

      // Fetch from API if Hive does not have the data
      final response = await _dio.get(
        '$url/shops',
        queryParameters: {
          'page': page,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> items = response.data;
        // Convert response data to ShopModel
        ShopModel shopModel = ShopModel.fromJson(items);
        // Save data to Hive for offline access
        await _saveShopsToHive(shopModel);
        return shopModel;
      } else {
        debugPrint("Failed to load shops. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Error in getShops: $e");
      return null;
    }
  }

  Future<ShopModel?> _getShopsFromHive() async {
    final box = await Hive.openBox(_hiveBoxName);
    final shopData = box.get('shopData');

    if (shopData != null) {
      try {
        return ShopModel.fromJson(shopData);
      } catch (e) {
        debugPrint("Error parsing Hive data: $e");
      }
    }
    return null;
  }

  Future<void> _saveShopsToHive(ShopModel shopModel) async {
    final box = await Hive.openBox(_hiveBoxName);
    final shopJson = shopModel.toJson();
    await box.put('shopData', shopJson);
  }
}
