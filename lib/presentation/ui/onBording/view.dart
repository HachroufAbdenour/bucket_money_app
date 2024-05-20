import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_app/presentation/ui/onBording/widget/custom_textfield.dart';
import 'package:money_app/presentation/ui/onbording/controller.dart';
import 'package:money_app/presentation/ui/transactions/transactions_screen.dart';
import 'package:lottie/lottie.dart';

class View extends StatelessWidget {
  final ViewController controller = Get.put(ViewController());  // Initialize controller

  View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset('assets/AnimationiNFO.json', width: 300, height: 150),
                const SizedBox(height: 20),
                Text("Enter your Fullname", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: MyTextField(controller: controller.fullnameController, hintText: "Enter your FullName"),
                ),
                InkWell(
                  onTap: () => controller.pickImage(),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.folder_open, color: Colors.blue),
                    const SizedBox(width: 10),
                    Text("Pick your image", style: TextStyle(color: Colors.blue)),
                  ]),
                ),
                const SizedBox(height: 20),
                Obx(() => controller.image.value != null
                    ? CircleAvatar(radius: 100, backgroundImage: FileImage(controller.image.value!))
                    : Container()),
                const SizedBox(height: 20),
                MyFilledButton(
                  onPressed: () => controller.submit(),
                  child: const Text("Done", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
