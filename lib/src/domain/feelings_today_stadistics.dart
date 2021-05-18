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
  print(res);
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
  for (var e in response) {
    Map element = Map.from(e);
    print(element['date']);
    print(element['sentiment']['document_tone']['tones']);
  }

  // var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  final felicidad = [
    new LinearSales(0, 5),
    new LinearSales(3, 3),
    new LinearSales(7, 2),
  ];

  var tristeza = [
    new LinearSales(0, 10),
    new LinearSales(56, 3),
  ];

  var enojo = [
    new LinearSales(0, 15),
    new LinearSales(7, 56),
  ];

  var miedo = [
    new LinearSales(8, 14.0212),
    new LinearSales(9, 200),
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
