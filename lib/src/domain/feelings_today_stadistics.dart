import 'dart:ffi';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class TodayFeelings {
  final String month;
  final int price;
  final charts.Color barColor;
  TodayFeelings(
      {@required this.month, @required this.price, @required this.barColor});

  Future<void> getFeelings(String userid) async {
    var url =
        Uri.parse('https://emcare-expressjs-api.herokuapp.com/get-feelings');
    var response = await http.post(
      url,
      body: {
        'userid': userid,
      },
    );
    print(response);
  }
}

class Tone {
  final Float score;
  final String toneId;
  final String toneName;

  Tone(this.score, this.toneId, this.toneName);
}

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
