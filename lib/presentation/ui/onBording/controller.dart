import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:money_app/data/local_storage/local_storage.dart';
import 'package:money_app/presentation/ui/transactions/transactions_screen.dart';

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
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      _storage.write('image', pickedFile.path); // Save image path to storage
    }
  }

  void saveFullName() {
    if (fullnameController.text.isNotEmpty) {
      _storage.write('fullName', fullnameController.text);
    }
  }

  void submit() {
    if (fullnameController.text.isNotEmpty && image.value != null) {
      saveFullName();
      LocalStorage().setIsFirstTime(false);
      Get.off(() => TransactionsScreen());
    } else {
      Get.snackbar("Error", "Please enter all information", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
