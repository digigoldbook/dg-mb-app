import 'package:hive_flutter/hive_flutter.dart';

double depostePrice(
  double buyGoldPrice,
  double goldWeight,
  double insuranceRate,
) {
  double totalAmount = (buyGoldPrice * goldWeight);
  insuranceRate /= 100;

  double discount = totalAmount * insuranceRate;
  totalAmount -= discount;

  var box = Hive.box('estimationData');
  box.put("depositePriceEstimation", totalAmount);

  return totalAmount;
}
