import 'package:dio/dio.dart';

import '../../../../components/utils/app_service.dart';
import '../model/gold_deposit_model.dart';

class Golddepositservice {
  final HttpService _httpService = HttpService();

  Future<GoldDepositModel> fetchItems() async {
    try {
      final response = await _httpService.get("/gold-deposit/");
      if (response.statusCode == 200) {
        return GoldDepositModel.fromJson(response.data);
      } else {
        throw 'Failed to Fetch Data';
      }
    } catch (error) {
      throw "Error: $error";
    }
  }

  Future<Response> submitGoldDeposit(Map<String, dynamic> data) async {
    try {
      final response = await _httpService.post('/gold-deposit/', data: data);
      return response;
    } catch (e) {
      throw '$e';
    }
  }
}
