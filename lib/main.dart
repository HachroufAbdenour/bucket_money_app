import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:money_app/data/local_storage/local_storage.dart';
import 'package:money_app/data/repositories/account_repository.dart';
import 'package:money_app/data/repositories/transactions_repository.dart';
import 'package:money_app/domain/repositories/account_repository_impl.dart';
import 'package:money_app/domain/repositories/transactions_repository_impl.dart';
import 'package:money_app/presentation/bindings/global_binding.dart';
import 'package:money_app/presentation/router/router.dart';
import 'package:money_app/presentation/router/routes.dart';
import 'package:money_app/presentation/ui/splash/splash_screen.dart';
import 'package:money_app/presentation/ui/transactions/transactions_controller.dart';
import 'package:money_app/presentation/ui/transactions/transactions_screen.dart';
import 'package:money_app/shared/constants/app_values.dart';
import 'package:money_app/shared/localization/keys.dart';
import 'package:money_app/shared/localization/translations.dart';
import 'package:money_app/shared/themes/themes.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  if (kIsWeb) {
    setPathUrlStrategy();
  }
  runApp( MoneyApp());
}

class ThemeController extends ChangeNotifier {
  bool _isDarkMode = false;

  ThemeData get currentTheme => _isDarkMode ? AppThemes.dark : AppThemes.light;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}


class MoneyApp extends StatelessWidget {
  final LocalStorage localStorage = Get.put(LocalStorage());

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: FutureBuilder<bool>(
        future: localStorage.getIsFirstTime(), // Get the isFirstTime flag
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If the future is still loading, return a loading indicator or splash screen
            return SplashScreen();
          } else if (snapshot.hasError) {
            // If an error occurred while fetching the flag, handle it here
            return Scaffold(
              body: Center(
                child: Text('Error loading isFirstTime flag'),
              ),
            );
          } else {
            // If the flag is successfully loaded, determine the initial route
            final bool isFirstTime = snapshot.data ?? true;
            return GetMaterialApp(
              navigatorKey: Get.key,
              getPages: AppRouter.routes,
              title: StringsKeys.moneyApp.tr,
              translations: AppTranslations(),
              locale: Locale(localStorage.languageCode.value),
              theme: AppThemes.getTheme(false),
              debugShowCheckedModeBanner: false,
              initialRoute:  '/' ,
              initialBinding: BindingsBuilder(() {
                Get.lazyPut<LocalStorage>(() => LocalStorage(), fenix: true);
                Get.lazyPut<AccountRepository>(() => AccountRepositoryImpl(Get.find<LocalStorage>()), fenix: true);
                Get.lazyPut<TransactionsRepository>(() => TransactionsRepositoryImpl(Get.find<LocalStorage>()), fenix: true);
                Get.put(TransactionsController(Get.find<LocalStorage>(), Get.find<AccountRepository>(), Get.find<TransactionsRepository>()));
              }),
            );
          }
        },
      ),
    );
  }
}
