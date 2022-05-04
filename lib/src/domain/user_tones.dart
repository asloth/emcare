import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class UserTone {
  final String day;
  final num score;

  UserTone(this.day, this.score);

  static String getDay(int day) {
    if (day == DateTime.monday) {
      return 'Lunes';
    } else if (day == DateTime.tuesday) {
      return 'Martes';
    } else if (day == DateTime.wednesday) {
      return 'Miercoles';
    } else if (day == DateTime.thursday) {
      return 'Jueves';
    } else if (day == DateTime.friday) {
      return 'Viernes';
    } else if (day == DateTime.saturday) {
      return 'Sábado';
    } else if (day == DateTime.sunday) {
      return 'Domingo';
    }
    return 'nosé';
  }

  static Map getMaxEmotion(Map tones){
    Map maxEmotion = {'emotion': '', 'maxScore': 0.0 };
    tones.forEach((k,v) => {
      if (v>maxEmotion['maxScore']){
        maxEmotion['emotion'] = k,
        maxEmotion['maxScore'] = v
      }
    });
    return maxEmotion;
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<UserTone, String>> setData(List response) {
    List<UserTone> hapiness = [];
    List<UserTone> sadness = [];
    List<UserTone> anger = [];
    List<UserTone> fear = [];
    List<UserTone> love = [];
    List<UserTone> surprise = [];
    DateTime today = DateTime.now();
    DateTime flag = today.subtract(Duration(days: 7));

    for (var e in response) {
      print(e);
      Map element = Map.from(e);
      int timestamp = element['date']['_seconds'];
      DateTime eDate = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      var tones = element['sentiment'];
      if (eDate.isAfter(flag)) {
        String wekday = getDay(eDate.weekday);
        Map dayEmotion = getMaxEmotion(tones);
          if (dayEmotion['emotion'] == 'sad') {
            sadness.add(new UserTone(wekday, dayEmotion['maxScore']));
          } else if (dayEmotion['emotion'] == 'joy') {
            hapiness.add(new UserTone(wekday, dayEmotion['maxScore']));
          } else if (dayEmotion['emotion'] == 'anger') {
            anger.add(new UserTone(wekday, dayEmotion['maxScore']));
          } else if (dayEmotion['emotion'] == 'fear') {
            fear.add(new UserTone(wekday, dayEmotion['maxScore']));
          }else if (dayEmotion['emotion'] == 'love'){
            love.add(new UserTone(wekday, dayEmotion['maxScore']));
          } else if (dayEmotion['emotion'] == 'surprise'){
            surprise.add(new UserTone(wekday, dayEmotion['maxScore']));
          }
      }
    }

    return [
      new charts.Series<UserTone, String>(
        id: 'Felicidad',
        domainFn: (UserTone sales, _) => sales.day,
        measureFn: (UserTone sales, _) => sales.score * 100,
        data: hapiness,
        seriesColor: charts.Color(
          r: 245,
          g: 243,
          b: 0,
          a: 96,
        ),
      ),
      new charts.Series<UserTone, String>(
        id: 'Tristeza',
        domainFn: (UserTone sales, _) => sales.day,
        measureFn: (UserTone sales, _) => sales.score * 100,
        data: sadness,
        seriesColor: charts.Color(
          r: 0,
          g: 161,
          b: 255,
          a: 100,
        ),
      ),
      new charts.Series<UserTone, String>(
        id: 'Enojo',
        domainFn: (UserTone sales, _) => sales.day,
        measureFn: (UserTone sales, _) => sales.score * 100,
        data: anger,
        seriesColor: charts.Color(
          r: 250,
          g: 53,
          b: 0,
          a: 98,
        ),
      ),
      new charts.Series<UserTone, String>(
        id: 'Miedo',
        domainFn: (UserTone sales, _) => sales.day,
        measureFn: (UserTone sales, _) => sales.score * 100,
        data: fear,
        seriesColor: charts.Color(
          r: 20,
          g: 222,
          b: 53,
          a: 87,
        ),
      ),
      new charts.Series<UserTone, String>(
        id: 'Amor',
        domainFn: (UserTone sales, _) => sales.day,
        measureFn: (UserTone sales, _) => sales.score * 100,
        data: love,
        seriesColor: charts.Color(
          r: 42,
          g: 219,
          b: 208,
          a: 86,
        ),
      ),
      new charts.Series<UserTone, String>(
        id: 'Sorpresa',
        domainFn: (UserTone sales, _) => sales.day,
        measureFn: (UserTone sales, _) => sales.score * 100,
        data: surprise,
        seriesColor: charts.Color(
          r: 182,
          g: 1,
          b: 137,
          a: 71,
        ),
      ),
    ];
  }

  static List<DataRow> setHistory(List response){
    List<DataRow> rows = [];
    for (var e in response){
      Map element = Map.from(e);
      int timestamp = element['date']['_seconds'];
      DateTime eDate = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      var tones = element['sentiment'];
      Map dayEmotion = getMaxEmotion(tones);
      String emotion= emotionInSpanish(dayEmotion['emotion']);
      rows.add(
        new DataRow(
          cells: <DataCell>[
            new DataCell(Text(eDate.toIso8601String().substring(0,10))),
            new DataCell(Text(emotion)),
            new DataCell(Text((dayEmotion['maxScore']*100).toStringAsFixed(2)+' %')),
          ],
        ),
      );
    }
    return rows;
  }

  static String emotionInSpanish(String englishName){
    if (englishName =='joy'){
      return 'Alegría';
    }else if (englishName=='anger'){
      return 'Enojo';
    }else if (englishName=='sad'){
      return 'Tristeza';
    }else if (englishName=='love'){
      return 'Amor';
    }else if (englishName=='fear'){
      return 'Miedo';
    }else if (englishName=='surprise'){
      return 'Sorpresa';
    }
    return '';
  }


}
