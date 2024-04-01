import 'package:get/get.dart';
import 'package:money_app/shared/constants/app_values.dart';
import 'package:money_app/shared/localization/languages/en.dart';
import 'package:money_app/shared/localization/languages/ar.dart';



class AppTranslations extends Translations {
  
  @override
  Map<String, Map<String, String>> get keys => {
    AppValues.langCodeEN: en,
    AppValues.langCodeAR: ar,
  };
}
