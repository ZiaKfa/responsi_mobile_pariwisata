class Produk {
  String? id;
  String? kodeProduk;
  String? namaProduk;
  var harga;
  
  Produk({this.id, this.kodeProduk, this.namaProduk, this.harga});

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: json['id'],
      kodeProduk: json['kode_produk'],
      namaProduk: json['nama_produk'],
      harga: json['harga'],
    );
  }
}