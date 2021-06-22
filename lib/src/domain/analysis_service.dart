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
}
