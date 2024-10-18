import 'dart:convert';

import 'package:jadwal_keberangkatan/helper/api.dart';
import 'package:jadwal_keberangkatan/helper/list_api.dart';
import 'package:jadwal_keberangkatan/model/registrasi.dart';

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