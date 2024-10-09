import 'dart:convert';
import 'package:toko_kita/helper/api.dart';
import 'package:toko_kita/helper/list_api.dart';
import 'package:toko_kita/model/login.dart';

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