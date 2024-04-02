import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesRepository {
  Future<void> saveCurrency(String key, String value);
  Future<String?> getCurrency(String key);
}

class SharedPreferencesRepositoryImpl implements SharedPreferencesRepository {
  @override
  Future<void> saveCurrency(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Future<String?> getCurrency(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
}
