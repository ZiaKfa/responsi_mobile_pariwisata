import 'package:flutter/material.dart';
import 'package:jadwal_keberangkatan/helper/user_info.dart';
import 'package:jadwal_keberangkatan/ui/login_page.dart';
import 'package:jadwal_keberangkatan/ui/jadwal_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const JadwalPage();
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Kita',
      debugShowCheckedModeBanner: false,
      home: page,
      theme: ThemeData(
        fontFamily: 'Helvetica',
      ),
    );
  }
}