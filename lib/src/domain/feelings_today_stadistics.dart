import 'package:emcare/src/presentation/screens/stadistics/widgets/stacked_area_line_chart.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:charts_flutter/flutter.dart' as charts;

Future<Response> getFeelings(String userid) async {
  var url =
      Uri.parse('https://emcare-expressjs-api.herokuapp.com/get-sentiment');
  var response = await http.post(
    url,
    body: {
      'userid': userid,
    },
  );
  print(response.body);
  return response;
}

/// Sample linear data type.
class Tone {
  final String toneId;
  final String toneName;
  final num score;

  Tone(this.toneId, this.toneName, this.score);
}

List<charts.Series<LinearSales, int>> createSampleData() {
  final myFakeDesktopData = [
    new LinearSales(0, 5),
    new LinearSales(1, 25),
    new LinearSales(2, 100),
    new LinearSales(3, 75),
  ];

  var myFakeTabletData = [
    new LinearSales(0, 10),
    new LinearSales(1, 50),
    new LinearSales(2, 200),
    new LinearSales(3, 150),
  ];

  var myFakeMobileData = [
    new LinearSales(0, 15),
    new LinearSales(1, 75),
    new LinearSales(2, 300),
    new LinearSales(3, 225),
  ];

  return [
    new charts.Series<LinearSales, int>(
      id: 'Desktop',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (LinearSales sales, _) => sales.year,
      measureFn: (LinearSales sales, _) => sales.sales,
      data: myFakeDesktopData,
    ),
    new charts.Series<LinearSales, int>(
      id: 'Tablet',
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      domainFn: (LinearSales sales, _) => sales.year,
      measureFn: (LinearSales sales, _) => sales.sales,
      data: myFakeTabletData,
    ),
    new charts.Series<LinearSales, int>(
      id: 'Mobile',
      colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
      domainFn: (LinearSales sales, _) => sales.year,
      measureFn: (LinearSales sales, _) => sales.sales,
      data: myFakeMobileData,
    ),
  ];
}
