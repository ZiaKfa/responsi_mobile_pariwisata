import 'package:jadwal_keberangkatan/helper/user_info.dart';

class LogoutBloc {
  static Future logout() async {
    await UserInfo().logout();
  }
}