import 'package:charts_flutter/flutter.dart' as charts;

class UserTone {
  final DateTime time;
  final num score;

  UserTone(this.time, this.score);

  /// Create one series with sample hard coded data.
  static List<charts.Series<UserTone, DateTime>> setData(List response) {
    List<UserTone> hapiness = [];
    List<UserTone> sadness = [];
    List<UserTone> anger = [];
    List<UserTone> fear = [];

    for (var e in response) {
      Map element = Map.from(e);
      int timestamp = element['date']['_seconds'];
      DateTime eDate = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
      var tones = element['sentiment']['document_tone']['tones'];
      for (var t in tones) {
        if (t['tone_id'] == 'sadness') {
          sadness.add(new UserTone(eDate, t['score']));
        } else if (t['tone_id'] == 'hapiness') {
          hapiness.add(new UserTone(eDate, t['score']));
        } else if (t['tone_id'] == 'anger') {
          anger.add(new UserTone(eDate, t['score']));
        } else if (t['tone_id'] == 'fear') {
          fear.add(new UserTone(eDate, t['score']));
        }
        ;
      }
    }

    return [
      new charts.Series<UserTone, DateTime>(
        id: 'Felicidad',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (UserTone userTone, _) => userTone.time,
        measureFn: (UserTone userTone, _) => userTone.score,
        data: hapiness,
      ),
      new charts.Series<UserTone, DateTime>(
        id: 'Tristeza',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (UserTone userTone, _) => userTone.time,
        measureFn: (UserTone userTone, _) => userTone.score,
        data: sadness,
      ),
      new charts.Series<UserTone, DateTime>(
          id: 'Enojo',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (UserTone userTone, _) => userTone.time,
          measureFn: (UserTone userTone, _) => userTone.score,
          data: anger),
      new charts.Series<UserTone, DateTime>(
          id: 'Miedo',
          colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
          domainFn: (UserTone userTone, _) => userTone.time,
          measureFn: (UserTone userTone, _) => userTone.score,
          data: fear)
        // Configure our custom point renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customPoint'),
    ];
  }
}
