import 'dart:convert';

import 'package:toko_kita/helper/api.dart';
import 'package:toko_kita/helper/list_api.dart';
import 'package:toko_kita/model/registrasi.dart';

class RegistrasiBloc {
  static Future<Registrasi> registrasi (
    {
      String? nama,
      String? email,
      String? password,
    }
  ) async {
    String url = ApiUrl.registrasi;
    var body = {
      "nama": nama,
      "email": email,
      "password": password,
    };

    var response = await Api().post(url, body);
    var jsonObj = json.decode(response);
    return Registrasi.fromJson(jsonObj);
  }
}