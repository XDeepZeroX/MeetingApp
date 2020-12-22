import 'dart:convert';

import 'package:dio/dio.dart';

import 'config.dart';
import 'package:http/http.dart' as http;

class Session {
  static String Token = '';
  static Map<String, String> get authHeaders =>
      {'Authorization': 'Bearer ${Token}'};

  Future<String> authorize(String email, String password) async {
    var uri = "${Config.serverUrl}api/User?username=$email&password=$password";
    print('GET: $uri');

    try {
      var res = await http.get(uri);
      if (res.statusCode == 200) {
        Session.Token = json.decode(res.body)['access_token'];
        return '';
      } else {
        if (res.body != null) {
          var jsonBody = json.decode(res.body);
          if (jsonBody['errorText'] != null) return jsonBody['errorText'];
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return 'Сервер не доступен';
  }
}
