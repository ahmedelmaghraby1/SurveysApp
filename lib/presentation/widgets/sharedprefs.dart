import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferances {
  Future setint(String variable, int token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(variable, token);
  }

  Future<int?> getint(String variable) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt(variable);
  }

  Future setstring(String variable, String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(variable, token);
  }

  Future<String?> getstring(String variable) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(variable);
  }

  Future<bool> setbool(String variable, bool flag) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setBool(variable, flag);
  }

  Future<bool?> getbool(String variable) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(variable);
  }

  Future<void> clear() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.clear();
  }
}
