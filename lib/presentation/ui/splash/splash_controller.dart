import 'package:get/get.dart';
import 'package:money_app/presentation/router/routes.dart';
import 'package:money_app/shared/utils/utils.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    start();
  }

  void start() async {
    await delayedFunc(milliseconds: 3590);
    goTransactions();
  }

  void goTransactions() => Get.toNamed(AppRoutes.onBording);
                     }
