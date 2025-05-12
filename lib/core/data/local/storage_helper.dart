import 'package:shared_preferences/shared_preferences.dart';

import 'get_store_keys.dart';

class StorageHelper {
  // Language
  static setLang(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedKeys.lang, lang);
  }

  static Future<String?> getLang() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedKeys.lang);
  }

  // Token
  static setAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedKeys.accessToken, token);
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(SharedKeys.accessToken) ?? '';
    return token;
  }

  static void clearAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(SharedKeys.accessToken);
  }

  // Permissions
  static setPermissions(bool permissions) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(SharedKeys.permissions, permissions);
  }

  static Future<bool> getPermissions() async {
    final prefs = await SharedPreferences.getInstance();
    final isPermissions = prefs.getBool(SharedKeys.permissions) ?? true;
    return isPermissions;
  }

  static void clearPermissions() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(SharedKeys.permissions);
  }

  // BranchId
  static setBranchId(String branchId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedKeys.branchId, branchId);
  }

  static Future<String> getBranchId() async {
    final prefs = await SharedPreferences.getInstance();
    var branchId = prefs.getString(SharedKeys.branchId) ?? '';
    return branchId;
  }

  static void clearBranchId() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(SharedKeys.branchId);
  }

  static void signOut() async {
    final prefs = await SharedPreferences.getInstance();
    final isPermissions = await getPermissions();
    if (isPermissions) {
      clearAccessToken();
      clearPermissions();
      clearBranchId();
    }
  }
}
