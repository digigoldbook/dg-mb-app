import 'package:flutter_application_1/components/utils/app_service.dart';

HttpService _httpService = HttpService();
Future<bool> deleteShop(int shopId) async {
  try {
    final response = await _httpService.delete("/shops", params: {
      "shopId": shopId,
    });
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
