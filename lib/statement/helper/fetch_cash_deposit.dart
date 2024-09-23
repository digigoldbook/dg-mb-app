import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../shop_screen/features/cash_deposit/model/cash_deposit_model.dart';

Future<CashDepositModel> fetchCashDeposits() async {
  final response = await http.get(
    Uri.parse('https://digigoldbook.com/api/cash-deposit'),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    Map<String, dynamic> items = data;

    return CashDepositModel.fromJson(items);
  } else {
    throw Exception('Failed to load cash deposits');
  }
}
