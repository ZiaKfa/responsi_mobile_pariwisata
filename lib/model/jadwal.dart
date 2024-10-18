class Jadwal {
  int? id;
  String? transport;
  String? route;
  String? frequency;

  Jadwal({this.id, this.transport, this.route, this.frequency});

  factory Jadwal.fromJson(Map<String, dynamic> obj) {
    return Jadwal(
      id: obj['id'],
      transport: obj['transport'],
      route: obj['route'],
      frequency: obj['frequency'],
    );
  }
  
}