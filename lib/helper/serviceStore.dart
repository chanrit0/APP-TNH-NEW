import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setStoreService(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool result = await prefs.setString(key, value);
  return result;
}

Future<dynamic> getStoreService(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final result = prefs.getString(key);
  return result;
}

Future<void> removeStoreService(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
  return;
}
