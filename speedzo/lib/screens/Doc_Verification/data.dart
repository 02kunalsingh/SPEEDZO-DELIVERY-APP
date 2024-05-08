import 'package:shared_preferences/shared_preferences.dart';

class UserInfoStorage {
  static const String _userNameKey = 'aadhar_number';

  static Future<String> getnumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey) ?? '';
  }

  static Future<void> setnumber(String aadhar) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userNameKey, aadhar);
  }
}
