import 'dart:convert';

import 'package:emcare/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class MyUser {
  String name;
  
  Future<Map> getUser(String userid) async {
    var endpoint = Uri.parse(api_url + 'get-user');

    var response = await http.post(
      endpoint,
      body: {
        'userid': userid,
      }
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map res = await json.decode(response.body);
      return res;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load user data');
    }    
  }

  static Future<String> updateUserName(String userid, String newname) async{
    String message;
    try {
      var endpoint = Uri.parse(api_url + 'update-user');

      var response = await http.post(
        endpoint,
        body: {
          'userid': userid,
          'newname': newname
        }
      );
      if (response.statusCode == 200){
        message = 'Actualizado correctamente';
      }
    } catch (e) {
      message = 'Ocurrió un problema al actualizar el nombre';
    }
    
    return message;
  }

  static Future<String> updatePassword(String newPassword, User firebaseU) async{
    String message;
    try {
      firebaseU.updatePassword(newPassword);
      firebaseU.reload();
      message = 'Actualización correcta';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password'){
        message = 'Clave débil';
      }

      if (e.code == 'requires-recent-login'){
        message = 'Se requiere que inicie sesión nuevamente';
      }
    }
    return message;
  }
}