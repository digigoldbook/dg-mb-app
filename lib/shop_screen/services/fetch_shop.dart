import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../components/utils/app_service.dart';
import '../model/shop_model.dart';

const String _hiveBoxName = 'shopBox';

class FetchShopService {
  final HttpService _httpService = HttpService(); // Use the HttpService

  Future<ShopModel?> getShops({int? page}) async {
    try {
      // Fetch shops from Hive storage first
      final shopsFromHive = await _getShopsFromHive();
      if (shopsFromHive != null && shopsFromHive.shopData != null) {
        return shopsFromHive;
      }

      // If not found in Hive, fetch from the API using HttpService
      final response = await _httpService.get(
        '/shops',
        queryParameters: {'page': page},
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
