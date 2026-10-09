import 'package:shared_preferences/shared_preferences.dart';

class ConfigService {
  static const String _keyIp = 'esp32_ip';
  static const String _keyJsonConfig = 'esp32_json_config';

  static Future<void> saveConfig(String ip, String jsonString) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyIp, ip);
    await prefs.setString(_keyJsonConfig, jsonString);
  }

  static Future<String?> getSavedIp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyIp);
  }

  static Future<String?> getSavedJsonConfig() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyJsonConfig);
  }

  static Future<void> clearConfig() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyIp);
    await prefs.remove(_keyJsonConfig);
  }
}