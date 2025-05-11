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
  static setPermissions(bool permissions) {
    _storage.write(StorageKeys.permissions, permissions);
  }

  static bool getPermissions() {
    return _storage.read(StorageKeys.permissions);
  }

  static void clearPermissions() {
    _storage.remove(StorageKeys.permissions);
  }

  // Permissions
  static setBranchId(String branchId) {
    _storage.write(StorageKeys.branchId, branchId);
  }

  static String getBranchId() {
    return _storage.read(StorageKeys.branchId);
  }

  static void clearBranchId() {
    _storage.remove(StorageKeys.branchId);
  }

  static void signOut() {
    if (_storage.read(StorageKeys.permissions)) {
      clearAccessToken();
      clearPermissions();
      clearBranchId();
    }
  }

  // Clear all storage (for logout)
  static void clearAll() {
    _storage.erase();
  }
}
