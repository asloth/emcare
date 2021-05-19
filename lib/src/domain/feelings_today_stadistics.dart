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
class Tone {
  final String toneName;
  final num score;

  Tone(this.toneName, this.score);
}

List<charts.Series<Tone, String>> createSampleData(List response) {
  List<Tone> hapiness = [];

  List<Tone> sadness = [];

  List<Tone> anger = [];

  List<Tone> fear = [];

  for (var e in response) {
    Map element = Map.from(e);
    var tones = element['sentiment']['document_tone']['tones'];
    for (var t in tones) {
      if (t['tone_id'] == 'sadness') {
        sadness.add(new Tone('Tristeza', t['score']));
      } else if (t['tone_id'] == 'hapiness') {
        hapiness.add(new Tone('Felicidad', t['score']));
      } else if (t['tone_id'] == 'anger') {
        anger.add(new Tone('Enojo', t['score']));
      } else if (t['tone_id'] == 'fear') {
        fear.add(new Tone('Miedo', t['score']));
      }
    }
  }

  return [
    new charts.Series<Tone, String>(
      id: 'Felicidad',
      domainFn: (Tone tone, _) => tone.toneName,
      measureFn: (Tone tone, _) => tone.score,
      data: hapiness,
    ),
    new charts.Series<Tone, String>(
      id: 'Tristeza',
      domainFn: (Tone tone, _) => tone.toneName,
      measureFn: (Tone tone, _) => tone.score,
      data: sadness,
    ),
    new charts.Series<Tone, String>(
      id: 'Enojo',
      domainFn: (Tone tone, _) => tone.toneName,
      measureFn: (Tone tone, _) => tone.score,
      data: anger,
    ),
    new charts.Series<Tone, String>(
      id: 'Miedo',
      domainFn: (Tone tone, _) => tone.toneName,
      measureFn: (Tone tone, _) => tone.score,
      data: fear,
    ),
  ];
}
