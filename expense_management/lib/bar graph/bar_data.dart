import 'package:expense_management/bar%20graph/individual_bar.dart';

class BarData {
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thurAmount;
  final double friAmount;
  final double satAmount;

  BarData({
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thurAmount,
    required this.friAmount,
    required this.satAmount,
  });

  List<individualBar> barData = [];

  void initializeBarData() {
    barData = [
      individualBar(x: 0, y: sunAmount),
      individualBar(x: 1, y: monAmount),
      individualBar(x: 2, y: tueAmount),
      individualBar(x: 3, y: wedAmount),
      individualBar(x: 4, y: thurAmount),
      individualBar(x: 5, y: friAmount),
      individualBar(x: 6, y: satAmount),
    ];
  }
}
