import 'dart:convert';

import 'package:toko_kita/helper/api.dart';
import 'package:toko_kita/helper/list_api.dart';
import 'package:toko_kita/model/produk.dart';

class ProdukBloc {
  static Future<List<Produk>> getProduk() async {
    String url = ApiUrl.produk;
    var response = await Api().get(url);
    var jsonObj = json.decode(response);
    List<dynamic> listProduk = (jsonObj as Map<String, dynamic>)['data'];
    List<Produk> produk = [];
    for (int i = 0; i < listProduk.length; i++){
      produk.add(Produk.fromJson(listProduk[i]));
      print(produk[i].namaProduk);
    }
    return produk;
  }

  static Future<Produk> addProduk(
      {Produk? produk}) async {
    String url = ApiUrl.produk;
    var data = {
      "kode_produk": produk!.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.harga.toString(),
    };
    var response = await Api().post(url, data);
    var jsonObj = json.decode(response);
    return Produk.fromJson(jsonObj);
  }

  static Future<Produk> updateProduk(
      {required Produk? produk}) async {
    String url = ApiUrl.updateProduk(produk!.id!);
    var data = {
      "kode_produk": produk.kodeProduk,
      "nama_produk": produk.namaProduk,
      "harga": produk.harga.toString(),
    };
    var response = await Api().put(url, data);
    var jsonObj = json.decode(response);
    return jsonObj['status'];
  }

  static Future<Produk> deleteProduk(
      {required int? id}) async {
    String url = ApiUrl.deleteProduk(id!);
    var response = await Api().delete(url);
    var jsonObj = json.decode(response);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}