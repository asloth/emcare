import 'package:emcare/src/domain/feelings_today_stadistics.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

List<List> menuItemsData = [
  [Icons.message, 'Chat'],
  [Icons.message_sharp, 'Estadisticas'],
];

final List<TodayFeelings> data = [
  TodayFeelings(
    month: "Jan",
    price: 50000,
    barColor: charts.ColorUtil.fromDartColor(Colors.red),
  ),
  TodayFeelings(
    month: "Feb",
    price: 60000,
    barColor: charts.ColorUtil.fromDartColor(Colors.blue),
  ),
  TodayFeelings(
    month: "March",
    price: 58000,
    barColor: charts.ColorUtil.fromDartColor(Colors.green),
  ),
];
