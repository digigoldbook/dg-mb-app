import 'package:dio/dio.dart';

import '../../components/utils/app_service.dart';

HttpService _httpService = HttpService();
final Dio dio = Dio();
Future<bool> deleteShop(int shopId) async {
  try {
    final dResponse =
        await dio.delete("http://192.168.1.79:3000/shops?shopId=$shopId");
    // final response = await _httpService.delete("/shops", params: {
    //   "shopId": shopId,
    // });
    if (dResponse.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}
