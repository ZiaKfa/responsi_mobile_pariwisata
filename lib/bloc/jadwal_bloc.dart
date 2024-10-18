import 'dart:convert';

import 'package:jadwal_keberangkatan/helper/api.dart';
import 'package:jadwal_keberangkatan/helper/list_api.dart';
import 'package:jadwal_keberangkatan/model/jadwal.dart';

class JadwalBloc {
  static Future<List<Jadwal>> getJadwal() async {
    String url = ApiUrl.jadwal;
    var response = await Api().get(url);
    var jsonObj = json.decode(response);
    List<dynamic> listJadwal = (jsonObj as Map<String, dynamic>)['data'];
    List<Jadwal> jadwal = [];
    for (int i = 0; i < listJadwal.length; i++){
      jadwal.add(Jadwal.fromJson(listJadwal[i]));
      print(jadwal[i].route);
    }
    return jadwal;
  }

  static Future<Jadwal> addJadwal(
      {Jadwal? jadwal}) async {
    String url = ApiUrl.jadwal;
    var data = {
      "transport": jadwal!.transport,
      "route": jadwal.route,
      "frequency": jadwal.frequency.toString(),
    };
    var response = await Api().post(url, data);
    var jsonObj = json.decode(response);
    return Jadwal.fromJson(jsonObj);
  }

static Future<bool> updateJadwal({required Jadwal? jadwal}) async {
  String url = ApiUrl.updateJadwal(jadwal!.id!);

  var data = jsonEncode({
    "transport": jadwal.transport,
    "route": jadwal.route,
    "frequency": jadwal.frequency,
  });
  
  print(data);
  var response = await Api().put(url,data,);
  var jsonObj = json.decode(response);
  return jsonObj['status'];
}

  static Future<bool> deleteJadwal(
      {required int? id}) async {
    String url = ApiUrl.deleteJadwal(id!);
    var response = await Api().delete(url);
    var jsonObj = json.decode(response);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}