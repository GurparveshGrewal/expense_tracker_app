import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferencesRepository {
  Future<void> saveCurrency(String value);
  Future<String?> getCurrency();
  Future<void> clearSharedPrefs();
}

class SharedPreferencesRepositoryImpl implements SharedPreferencesRepository {
  static const String _keyNameCurrency = 'currency';

  @override
  Future<void> saveCurrency(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyNameCurrency, value);
  }

  @override
  Future<String?> getCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    final c = prefs.getString(_keyNameCurrency);
    return c;
  }

  @override
  Future<void> clearSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
