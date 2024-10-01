class Produk {
  int? id;
  String? kodeProduk;
  String? namaProduk;
  int? harga;

  Produk({this.id, this.kodeProduk, this.namaProduk, this.harga});

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: json['id'],
      kodeProduk: json['kodeProduk'],
      namaProduk: json['namaProduk'],
      harga: json['harga'],
    );
  }

  get hargaProduk => null;
}