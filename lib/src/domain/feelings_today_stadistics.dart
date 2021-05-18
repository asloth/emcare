import 'dart:convert';

import 'package:emcare/src/presentation/screens/stadistics/widgets/stacked_area_line_chart.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:charts_flutter/flutter.dart' as charts;

Future<List> getFeelings(String userid) async {
  var url =
      Uri.parse('https://emcare-expressjs-api.herokuapp.com/get-sentiment');
  var response = await http.post(
    url,
    body: {
      'userid': userid,
    },
  );
  List res = await json.decode(response.body);

  return res;
}

/// Sample linear data type.
class Tone {
  final String toneId;
  final String toneName;
  final num score;
  final int hour;

  Tone(this.toneId, this.toneName, this.score, this.hour);
}

List<charts.Series<LinearSales, int>> createSampleData(List response) {
  final felicidad = [
    new LinearSales(0, 5),
    new LinearSales(0, 3),
    new LinearSales(0, 2),
  ];

  var tristeza = [
    new LinearSales(0, 10),
    new LinearSales(0, 10),
  ];

  var enojo = [
    new LinearSales(0, 15),
    new LinearSales(0, 15),
  ];

  var miedo = [
    new LinearSales(0, 14.0212),
    new LinearSales(0, 14.0212),
  ];

  return [
    new charts.Series<LinearSales, int>(
      id: 'Felicidad',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (LinearSales sales, _) => sales.year,
      measureFn: (LinearSales sales, _) => sales.sales,
      data: felicidad,
    ),
    new charts.Series<LinearSales, int>(
      id: 'Tristeza',
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      domainFn: (LinearSales sales, _) => sales.year,
      measureFn: (LinearSales sales, _) => sales.sales,
      data: tristeza,
    ),
    new charts.Series<LinearSales, int>(
      id: 'Enojo',
      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      domainFn: (LinearSales sales, _) => sales.year,
      measureFn: (LinearSales sales, _) => sales.sales,
      data: enojo,
    ),
    new charts.Series<LinearSales, int>(
      id: 'Miedo',
      colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
      domainFn: (LinearSales sales, _) => sales.year,
      measureFn: (LinearSales sales, _) => sales.sales,
      data: miedo,
    ),
  ];
}
