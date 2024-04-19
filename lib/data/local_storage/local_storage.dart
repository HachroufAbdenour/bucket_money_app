import 'dart:ffi';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocalStorage extends GetxController {
  final GetStorage _box = GetStorage();
static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() => _instance;

  LocalStorage._internal();

  static const String _isFirstTimeKey = 'isFirstTime';

  Future<void> setIsFirstTime(bool value) async {
    final box = GetStorage();
    await box.write(_isFirstTimeKey, value);
  }

  Future<bool> getIsFirstTime() async {
    final box = GetStorage();
    return box.read(_isFirstTimeKey) ?? false;
  }

  
  static const String _account = '_account';
  static const String _transactions = '_transactions';

  Future<void> setAccount(final String? v) async => await _setValue(_account, v);
  Future<String?> getAccount() async => await _getValue(_account);

  Future<void> setTransactions(final String? v) async => await _setValue(_transactions, v);
  Future<String?> getTransactions() async => await _getValue(_transactions);

  Future<T> _getValue<T>(final String key) async => await _box.read(key) as T;

  Future<void> _setValue<T>(final String key, final T v) async => await _box.write(key, v);

  Future<void> clearBox() async {
    await Future.wait([
      _box.remove(_account),
      _box.remove(_transactions),
    ]);
  }





//save language 
final languageCode = 'en'.obs; 


 @override
  void onInit() {
    super.onInit();
    // Load saved language preference on initialization
    loadLanguagePreference();
  }


  // Load saved language preference
  
  // Load saved language preference or set default language to device default
  Future<void> loadLanguagePreference() async {
    final box = GetStorage();
    if (box.hasData('language')) {
      languageCode.value = box.read('language');
    } else {
      // If no language preference is saved, use the default language of the device
      languageCode.value = Get.deviceLocale?.languageCode ?? 'en';
      await saveLanguagePreference(languageCode.value);
    }
  }

  // Save language preference
  Future<void> saveLanguagePreference(String languageCod) async {
    final box = GetStorage();
    await box.write('language', languageCod);
    this.languageCode.value = languageCod;
  }


}


