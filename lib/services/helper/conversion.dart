import '../utils/conversion_factors.dart';

double convertUnit(double value, String fromUnit, String toUnit) {
  // Convert the input value to grams
  double valueInGrams = value * unitToGrams[fromUnit]!;

  // Convert grams to the target unit
  return valueInGrams / unitToGrams[toUnit]!;
}
