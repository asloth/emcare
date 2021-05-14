import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class TodayFeelings {
  final String month;
  final int price;
  final charts.Color barColor;
  TodayFeelings(
      {@required this.month, @required this.price, @required this.barColor});
}
