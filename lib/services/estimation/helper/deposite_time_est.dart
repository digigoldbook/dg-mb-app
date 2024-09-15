import 'package:hive_flutter/hive_flutter.dart';

double deposteTimeEstimation(double rate) {
  var box = Hive.box('estimationData');
  double gp = box.get('goldBuyAmount');
  double dpe = box.get("depositePriceEstimation");
  double interest = gp - dpe;

  double dte = (interest * dpe * rate);
  return dte;
}
