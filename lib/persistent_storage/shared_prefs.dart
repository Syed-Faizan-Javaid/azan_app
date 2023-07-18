import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static late final SharedPreferences _instance;

  static Future<SharedPreferences> init() async =>
      _instance = await SharedPreferences.getInstance();

  static bool? getBool(String key) => _instance.getBool(key);
  static Future<bool> setBool(String key, bool value) =>
      _instance.setBool(key, value);

  static String? getString(String key) => _instance.getString(key);
  static Future<bool> setString(String key, String value) =>
      _instance.setString(key, value);

  static int? getInt(String key) => _instance.getInt(key);
  static Future<bool> setInt(String key, int value) =>
      _instance.setInt(key, value);

  static Future<bool> remove(String key) => _instance.remove(key);
}
