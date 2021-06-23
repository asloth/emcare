import 'package:charts_flutter/flutter.dart' as charts;

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

  /// Create one series with sample hard coded data.
  static List<charts.Series<UserTone, String>> setData(List response) {
    List<UserTone> hapiness = [];
    List<UserTone> sadness = [];
    List<UserTone> anger = [];
    List<UserTone> fear = [];
    DateTime today = DateTime.now();
    DateTime flag = today.subtract(Duration(days: 7));

    for (var e in response) {
      Map element = Map.from(e);
      int timestamp = element['date']['_seconds'];
      DateTime eDate = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      var tones = element['sentiment']['document_tone']['tones'];
      if (eDate.isAfter(flag)) {
        String wekday = getDay(eDate.weekday);
        for (var t in tones) {
          if (t['tone_id'] == 'sadness') {
            sadness.add(new UserTone(wekday, t['score']));
          } else if (t['tone_id'] == 'joy') {
            hapiness.add(new UserTone(wekday, t['score']));
          } else if (t['tone_id'] == 'anger') {
            anger.add(new UserTone(wekday, t['score']));
          } else if (t['tone_id'] == 'fear') {
            fear.add(new UserTone(wekday, t['score']));
          }
        }
      }
    }

    return [
      new charts.Series<UserTone, String>(
        id: 'Felicidad',
        domainFn: (UserTone sales, _) => sales.day,
        measureFn: (UserTone sales, _) => sales.score,
        data: hapiness,
      ),
      new charts.Series<UserTone, String>(
        id: 'Tristeza',
        domainFn: (UserTone sales, _) => sales.day,
        measureFn: (UserTone sales, _) => sales.score,
        data: sadness,
      ),
      new charts.Series<UserTone, String>(
        id: 'Enojo',
        domainFn: (UserTone sales, _) => sales.day,
        measureFn: (UserTone sales, _) => sales.score,
        data: anger,
      ),
      new charts.Series<UserTone, String>(
          id: 'Miedo',
          domainFn: (UserTone sales, _) => sales.day,
          measureFn: (UserTone sales, _) => sales.score,
          data: fear),
    ];
  }
}
