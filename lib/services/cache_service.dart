import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _cacheKey = 'companies_cache';

  Future<void> saveCompaniesJson(String json) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_cacheKey, json);
  }

  Future<String?> getCompaniesJson() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString(_cacheKey);
  }

  Future<void> clearCache() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove(_cacheKey);
  }
}
