class ApiUrl{
  static const String baseUrl = "http://responsi.webwizards.my.id/api";
  static const String login = "$baseUrl/login";
  static const String registrasi = "$baseUrl/registrasi";


  static const String jadwal = "$baseUrl/pariwisata/jadwal_keberangkatan";

  static String showJadwal(int id){
    return "$jadwal/${id.toString()}";
  }

  static String updateJadwal(int id){
    return "$jadwal/${id.toString()}/update";
  }

  static String deleteJadwal(int id){
    return "$jadwal/${id.toString()}/delete";
  }
}