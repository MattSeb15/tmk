import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences {
  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUserName(String userName) async =>
      await _preferences?.setString('userName', userName);

  static String? getUserName() => _preferences?.getString('userName');

  static Future setNumberWithKey(String key, int n) async => await _preferences?.setInt(key, n);

  static int? getNumberWithKey(String key) => _preferences?.getInt(key);

  static Future setStringWithKey(String key, String s) async => await _preferences?.setString(key, s);

  static String? getStringWithKey(String key) => _preferences?.getString(key);

  static Future<void> saveMap(String key, Map<String, dynamic> map) async {
    final jsonString = jsonEncode(map);
    await _preferences?.setString(key, jsonString);
  }

  static Map<String, dynamic> getMap(String key) {
    final jsonString = _preferences?.getString(key);
    if (jsonString != null) {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    }
    return {};
  }
}
