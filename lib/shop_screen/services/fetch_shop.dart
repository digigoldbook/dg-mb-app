import 'package:flutter/material.dart';

import '../../components/utils/app_service.dart';
import '../model/shop_model.dart';

class FetchShopService {
  final HttpService _httpService = HttpService();

  Future<ShopModel?> getShops({int? page}) async {
    try {
      // Fetch from the API using HttpService
      final response = await _httpService.get(
        '/shops',
        queryParameters: {'page': page},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> items = response.data;
        // Convert response data to ShopModel
        ShopModel shopModel = ShopModel.fromJson(items);
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
}
