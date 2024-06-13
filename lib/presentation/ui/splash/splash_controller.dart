import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:money_app/data/local_storage/local_storage.dart';
import 'package:money_app/presentation/router/routes.dart';

class SplashController extends GetxController {
  final LocalStorage localStorage = Get.put(LocalStorage());

  @override
  void onInit() {
    super.onInit();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      await _simulateLoading();  // Simulate some loading process
      _navigateBasedOnUserStatus();
    } catch (e) {
      print('Error initializing app: $e');
    }
  }

  Future<void> _simulateLoading() async => await Future.delayed(Duration(milliseconds: 3500));

  void _navigateBasedOnUserStatus()async {
    String route = await localStorage.getIsFirstTime() ? AppRoutes.onBording : AppRoutes.transactions;
    Get.offAllNamed(route);
  }
}
