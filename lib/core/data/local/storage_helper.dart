import 'package:get_storage/get_storage.dart';

import 'get_store_keys.dart';


class StorageHelper {
  static final _storage = GetStorage();

  // Language
  static setLang(String lang) {
    _storage.write(StorageKeys.lang, lang);
  }

  static String? getLang() {
    return _storage.read(StorageKeys.lang);
  }

  // Token
  static setAccessToken(String token) {
    _storage.write(StorageKeys.accessToken, token);
  }

  static String? getAccessToken() {
    return _storage.read(StorageKeys.accessToken);
  }

  static void clearAccessToken() {
    _storage.remove(StorageKeys.accessToken);
  }

  // Permissions
  static setPermissions(Map<String, dynamic> permissions) {
    _storage.write(StorageKeys.permissions, permissions);
  }

  static Map<String, dynamic>? getPermissions() {
    return _storage.read(StorageKeys.permissions);
  }

  // Clear all storage (for logout)
  static void clearAll() {
    _storage.erase();
  }
}