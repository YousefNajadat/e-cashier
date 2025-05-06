import 'package:get_storage/get_storage.dart';

import 'get_store_keys.dart';

class StorageHelper {
  static final _storage = GetStorage();

  //========================== lang ==============================================
  static setLang(String lang) {
    _storage.write(StorageKeys.lang, lang);
  }

  static String? getLang() {
    return _storage.read(StorageKeys.lang);
  }
}
