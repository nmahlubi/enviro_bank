import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  static set(key, value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  static get(key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getString(key);
  }

  static remove(key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }

  static logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
