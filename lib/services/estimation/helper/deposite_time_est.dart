import 'package:hive_flutter/hive_flutter.dart';

Future<double> deposteTimeEstimation(double rate) async {
  var box = await Hive.openBox("estimationData");

  double gp = box.get('goldBuyAmount');
  double dpe = box.get("depositePriceEstimation");
  double interest = gp - dpe;

  double dte = (interest * 100) / (dpe * rate);

  box.put("dte", dte);
  return dte;
}
