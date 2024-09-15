import 'package:hive_flutter/hive_flutter.dart';

Future<double> calculateBuyingPrice(
  double todayGoldPrice,
  double goldWeight,
  double rate,
) async {
  double totalAmount = (todayGoldPrice * goldWeight);
  rate /= 100;

  double discount = totalAmount * rate;
  totalAmount -= discount;

  var box = await Hive.openBox("estimationData");

  box.put('goldBuyAmount', totalAmount);
  box.put('productWeight', goldWeight);

  return totalAmount;
}
