import 'dart:convert';

import 'package:http/http.dart' as http;

class AnalysisService {
  AnalysisService();

  static Future<Map<String, dynamic>> getDataAnalysis(String userid) async {
    var url =
        Uri.parse('https://emcare-expressjs-api.herokuapp.com/get-analysis');
    var response = await http.post(
      url,
      body: {
        'userid': userid,
      },
    );
    Map<String, dynamic> res = await json.decode(response.body);
    return res;
  }

  static String getTendencyLabel(num slope) {
    String label = '';
    if (slope < 0) {
      if (slope < -0.01) {
        label = 'tendencia  negativa';
      } else {
        label = 'tendencia ligeramente negativa';
      }
    } else if (slope == 0) {
      label = 'tendencia constante';
    } else {
      if (slope < 0.01) {
        label = 'tendencia ligeramente positiva';
      } else {
        label = 'tendencia positiva';
      }
    }
    return label;
  }

  static String getRecommedation(num slope) {
    String rec = '';
    if (slope < 0) {
      if (slope < -0.01) {
        rec =
            'Si esto sigue así, por favor ten en cuenta acudir con un profesional de la salud';
      } else {
        rec =
            'Seguiremos atentos a tus estados de ánimo y te avisaremos si esta tendencia decae. ';
      }
    } else if (slope == 0) {
      rec = 'tendencia constante';
    } else {
      if (slope < 0.01) {
        rec = 'Parece que mejoraste ligeramente! Esperamos que sigas así';
      } else {
        rec =
            'Felicidades! De todas formas nos mantendremos atentos a tus estados de ánimo';
      }
    }
    return rec;
  }
}
