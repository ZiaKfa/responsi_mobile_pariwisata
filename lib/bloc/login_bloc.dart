import 'dart:convert';
import 'package:jadwal_keberangkatan/helper/api.dart';
import 'package:jadwal_keberangkatan/helper/list_api.dart';
import 'package:jadwal_keberangkatan/model/login.dart';

class LoginBloc {
  static Future<Login> login(
      {String? email, String? password}) async {
    String url = ApiUrl.login;
    var data = {
      "email": email,
      "password": password,
    };
    var response = await Api().post(url, data);
    var jsonObj = json.decode(response);
    return Login.fromJson(jsonObj);
  }
}