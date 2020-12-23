import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'config.dart';
import 'package:http/http.dart' as http;

class Session {
  static String Token = '';
  static int Id;
  static String Email;
  static Map<String, String> get authHeaders =>
      {'Authorization': 'Bearer ${Token}'};

  Future<String> authorize(String Email, String password) async {
    var uri = "${Config.serverUrl}api/User?username=$Email&password=$password";
    print('GET: $uri');

    try {
      var res = await http.get(uri);
      if (res.statusCode == 200) {
        Session.Token = json.decode(res.body)['access_token'];
        var token = JwtDecoder.decode(Session.Token);
        Id = int.parse(token['Id']);
        Email = token['Email'];
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
