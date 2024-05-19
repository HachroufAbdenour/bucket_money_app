import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:money_app/data/local_storage/local_storage.dart';
import 'package:money_app/presentation/ui/onbording/widget/custom_textfield.dart';
import 'package:money_app/presentation/ui/transactions/transactions_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:get_storage/get_storage.dart';
import 'package:money_app/shared/constants/app_values.dart';










class View extends StatefulWidget {
  const View({Key? key}) : super(key: key);

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  final fullnameController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final GetStorage _storage = GetStorage();

  @override
  void initState() {
    super.initState();
    _storage.writeIfNull('fullName', ''); // Ensure the key exists
  }

Future<void> pickImage() async {
  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    print("Picked file path: ${pickedFile.path}"); // Debugging line
    _storage.write('image', pickedFile.path); // Save image path to storage
    setState(() {
      _image = File(pickedFile.path);
    });
  }
}

  void saveFullName() {
    if (fullnameController.text.isNotEmpty) {
      _storage.write('fullName', fullnameController.text);
    }
  }

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
             
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                  Text("Enter your Fullname", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: MyTextField(controller: fullnameController, hintText: "Enter your FullName"),
                ),
                ],),
                InkWell(
                  onTap: pickImage,
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.folder_open, color: Colors.blue),
                    const SizedBox(width: 10),
                    Text("Pick your image", style: TextStyle(color: Colors.blue)),
                  ]),
                ),
                const SizedBox(height: 20),
                if (_image != null)
                  CircleAvatar(radius: 100, backgroundImage: FileImage(_image!)),
                const SizedBox(height: 20),
                MyFilledButton(
                  onPressed: () {
                    if (fullnameController.text.isNotEmpty && _image != null) {
                      saveFullName();
                      LocalStorage().setIsFirstTime(false);

                      Get.to(() => TransactionsScreen());
                    } else {
                      Get.snackbar("Error", "Please enter all information", backgroundColor: Colors.red, colorText: Colors.white);
                    }
                  },
                  child: CustomText("Done", fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }





   void setImagePath(String newPath) {
    _storage.write('image', newPath); // Save image path to storage
  }

  void getImage(File? _image, Function(File) setImage) async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    final image = File(pickedFile.path);
    setImage(image);
setImagePath(pickedFile.path);
 } else {
    print('No image selected.');
  }
}

}
