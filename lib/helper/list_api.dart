class ApiUrl{
  static const String baseUrl = "http://localhost:8080";
  static const String login = "$baseUrl/login";
  static const String registrasi = "$baseUrl/registrasi";
  static const String produk = "$baseUrl/produk";

  static String showProduk(String id){
    return "$baseUrl/produk/${id.toString()}";
  }

  static String updateProduk(String id){
    return "$baseUrl/produk/${id.toString()}";
  }

  static String deleteProduk(int id){
    return "$baseUrl/produk/${id.toString()}";
  }
}