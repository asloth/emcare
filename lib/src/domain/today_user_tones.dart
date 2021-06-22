import 'dart:convert';
import 'package:http/http.dart' as http;
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
class TodayUserTone {
  final String toneName;
  final num score;

  TodayUserTone(this.toneName, this.score);
}

List<charts.Series<TodayUserTone, String>> createSampleData(List response) {
  List<TodayUserTone> hapiness = [];
  List<TodayUserTone> sadness = [];
  List<TodayUserTone> anger = [];
  List<TodayUserTone> fear = [];

  for (var e in response) {
    Map element = Map.from(e);
    var tones = element['sentiment']['document_tone']['tones'];
    for (var t in tones) {
      if (t['tone_id'] == 'sadness') {
        sadness.add(new TodayUserTone('Tristeza', t['score']));
      } else if (t['tone_id'] == 'joy') {
        hapiness.add(new TodayUserTone('Felicidad', t['score']));
      } else if (t['tone_id'] == 'anger') {
        anger.add(new TodayUserTone('Enojo', t['score']));
      } else if (t['tone_id'] == 'fear') {
        fear.add(new TodayUserTone('Miedo', t['score']));
      }
    }
  }

  return [
    new charts.Series<TodayUserTone, String>(
      id: 'Felicidad',
      domainFn: (TodayUserTone tone, _) => tone.toneName,
      measureFn: (TodayUserTone tone, _) => tone.score,
      data: hapiness,
    ),
    new charts.Series<TodayUserTone, String>(
      id: 'Tristeza',
      domainFn: (TodayUserTone tone, _) => tone.toneName,
      measureFn: (TodayUserTone tone, _) => tone.score,
      data: sadness,
    ),
    new charts.Series<TodayUserTone, String>(
      id: 'Enojo',
      domainFn: (TodayUserTone tone, _) => tone.toneName,
      measureFn: (TodayUserTone tone, _) => tone.score,
      data: anger,
    ),
    new charts.Series<TodayUserTone, String>(
      id: 'Miedo',
      domainFn: (TodayUserTone tone, _) => tone.toneName,
      measureFn: (TodayUserTone tone, _) => tone.score,
      data: fear,
    ),
  ];
}
