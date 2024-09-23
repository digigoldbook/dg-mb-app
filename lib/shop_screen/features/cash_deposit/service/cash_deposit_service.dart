import 'package:dio/dio.dart';

import '../../../../components/utils/app_service.dart';
import '../model/cash_deposit_model.dart';

class Cashdepositservice {
  final HttpService _httpService = HttpService();

  Future<CashDepositModel> fetchItems() async {
    try {
      final response = await _httpService.get("/cash-deposit/");
      if (response.statusCode == 200) {
        return CashDepositModel.fromJson(response.data);
      } else {
        throw 'Failed to Fetch Data';
      }
    } catch (error) {
      throw "Error: $error";
    }
  }

  Future<Response> submitCashDeposit(Map<String, dynamic> data) async {
    try {
      final response = await _httpService.post('/cash-deposit/', data: data);

      return response;
    } catch (e) {
      throw "Error: $e";
    }
  }

  Future<Response> deleteCashDeposit(Map<String, dynamic> data) async {
    try {
      final response = await _httpService.delete(
        '/cash-deposit/',
        params: data,
      );

      return response;
    } catch (e) {
      throw "Error: $e";
    }
  }
}
