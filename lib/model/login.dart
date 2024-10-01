class Login{
  int? code;
  bool? status;
  String? token;
  int? id;
  String? email;

  Login({this.code, this.status, this.token, this.id, this.email});

  factory Login.fromJson(Map<String, dynamic> json){
    return Login(
      code: json['code'],
      status: json['status'],
      token: json['token'],
      id: json['id'],
      email: json['email'],
    );
  }
}