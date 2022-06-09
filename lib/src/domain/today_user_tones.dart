import 'dart:convert';
import 'package:emcare/constants.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

Future<List> getFeelings(String userid) async {
  var url = Uri.parse(api_url+'get-sentiment');
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
  List<TodayUserTone> love = [];
  List<TodayUserTone> surprise = [];

  for (var e in response) {
    Map element = Map.from(e);
    Map tones = element['sentiment'];
    Map todayEmotion = {'emotion': '', 'maxScore': 0.0 };
    tones.forEach((k,v) => {
      if (v>todayEmotion['maxScore']){
        todayEmotion['emotion'] = k,
        todayEmotion['maxScore'] = v
      }
    });
    if (todayEmotion['emotion'] == 'sad') {
      sadness.add(new TodayUserTone('Tristeza', todayEmotion['maxScore']));
    } else if (todayEmotion['emotion'] == 'joy') {
      hapiness.add(new TodayUserTone('Felicidad', todayEmotion['maxScore']));
    } else if (todayEmotion['emotion'] == 'anger') {
      anger.add(new TodayUserTone('Enojo', todayEmotion['maxScore']));
    } else if (todayEmotion['emotion'] == 'fear') {
      fear.add(new TodayUserTone('Miedo', todayEmotion['maxScore']));
    } else if (todayEmotion['emotion'] == 'love'){
      love.add(new TodayUserTone('Amor', todayEmotion['maxScore']));
    } else if (todayEmotion['emotion'] == 'surprise'){
      surprise.add(new TodayUserTone('Sorpresa', todayEmotion['maxScore']));
    }
  }

  return [
    new charts.Series<TodayUserTone, String>(
      id: 'Felicidad',
      domainFn: (TodayUserTone tone, _) => tone.toneName,
      measureFn: (TodayUserTone tone, _) => tone.score * 100,
      data: hapiness,
    ),
    new charts.Series<TodayUserTone, String>(
      id: 'Tristeza',
      domainFn: (TodayUserTone tone, _) => tone.toneName,
      measureFn: (TodayUserTone tone, _) => tone.score * 100,
      data: sadness,
    ),
    new charts.Series<TodayUserTone, String>(
      id: 'Enojo',
      domainFn: (TodayUserTone tone, _) => tone.toneName,
      measureFn: (TodayUserTone tone, _) => tone.score * 100,
      data: anger,
    ),
    new charts.Series<TodayUserTone, String>(
      id: 'Miedo',
      domainFn: (TodayUserTone tone, _) => tone.toneName,
      measureFn: (TodayUserTone tone, _) => tone.score * 100,
      data: fear,
    ),
    new charts.Series<TodayUserTone, String>(
      id: 'Amor',
      domainFn: (TodayUserTone tone, _) => tone.toneName,
      measureFn: (TodayUserTone tone, _) => tone.score * 100,
      data: love,
    ),
    new charts.Series<TodayUserTone, String>(
      id: 'Sorpresa',
      domainFn: (TodayUserTone tone, _) => tone.toneName,
      measureFn: (TodayUserTone tone, _) => tone.score * 100,
      data: surprise,
    ),
  ];
}
