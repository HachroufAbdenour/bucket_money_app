import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:money_app/data/local_storage/local_storage.dart';
import 'package:money_app/presentation/ui/transactions/transactions_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';



class ViewController extends GetxController {
  final fullnameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final GetStorage _storage = GetStorage();
  Rx<File?> image = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    _storage.writeIfNull('fullName', '');
  }

 Future<void> pickImage() async {
  final bool permissionGranted = await _requestPermission(Permission.storage);
  if (permissionGranted) {
    await _getDeviceInfo();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      _storage.write('image', pickedFile.path); // Save image path to storage
    }
  } else {
    Get.snackbar("Permission Denied", "Storage permission is required to pick an image.");
  }
}

//  Future<void> pickImage() async {
//     if (await _requestPermission(Permission.storage)) {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       image.value = File(pickedFile.path);
//       _storage.write('image', pickedFile.path); // Save image path to storage
//     }
//     } else {
//       Get.snackbar("Permission Denied", "Storage permission is required to pick an image.");
//     }
//   }

Future<bool> _requestPermission(Permission permission) async {
  final PermissionStatus status = await permission.request();
  return status.isGranted;
}


Future<void> _getDeviceInfo() async {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    // Use androidInfo for Android device information
  } else if (Platform.isIOS) {
    final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    // Use iosInfo for iOS device information
  }
}




  void saveFullName() {
    if (fullnameController.text.isNotEmpty) {
      _storage.write('fullName', fullnameController.text);
    }
  }

  void submit() async {
  final bool permissionGranted = await _requestPermission(Permission.storage);
  if (permissionGranted) {
    await _getDeviceInfo();
    if (fullnameController.text.isNotEmpty && image.value != null) {
      saveFullName();
      LocalStorage().setIsFirstTime(false);
      Get.off(() => TransactionsScreen());
    } else {
      Get.snackbar("Error", "Please enter all information", backgroundColor: Colors.red, colorText: Colors.white);
    }
  } else {
    Get.snackbar("Permission Denied", "Storage permission is required to proceed.");
  }
}

}
