import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:money_app/data/local_storage/local_storage.dart';
import 'package:money_app/presentation/ui/transactions/transactions_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:money_app/presentation/ui/onBording/widget/custom_textfield.dart';

class OnboardView extends StatefulWidget {
  @override
  _OnboardViewState createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final List<Widget> _pages = [
    OnboardingPage1(),
    OnboardingPage2(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Onboarding Demo'),
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return _pages[index % _pages.length];
            },
          ),
          Positioned(
            bottom: 16.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ),
        ],
      ),
      floatingActionButton: _currentPage == _pages.length - 1
          ? FloatingActionButton(
              onPressed: () {
                // Action when the last page is reached, like navigating to another screen
                // For now, just popping the screen
                Get.toNamed('/transactions');
              },
              child: Icon(Icons.arrow_forward),
            )
          : null,
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _pages.length; i++) {
      indicators.add(_indicator(i == _currentPage));
    }
    return indicators;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 8.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class OnboardingPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Lottie.asset('assets/Animation4.json', width: 300),
      ),
    );
  }
}

class OnboardingPage2 extends StatefulWidget {
  @override
  State<OnboardingPage2> createState() => _OnboardingPage2State();
}

class _OnboardingPage2State extends State<OnboardingPage2> {
  final TextEditingController _fullNameController = TextEditingController();
  File? _image;
  final _storage = GetStorage();

  Future getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _storage.write('image', pickedFile.path); // Save image path to storage
      } else {
        print('No image selected.');
      }
    });
  }

  void _saveFullName(String fullName) {
    _storage.write('fullName', fullName); // Save full name to storage
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Enter your full name",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 25),
            CustomTextField(
              controller: _fullNameController,
              name: 'Full Name',
              prefixIcon: Icons.person,
              obscureText: false,
              textCapitalization: TextCapitalization.words,
              inputType: TextInputType.text,
            ),
            Text(
              "Select your image for your Profile",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: getImage,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: _image == null
                      ? Text('Tap to select profile photo')
                      : CircleAvatar(
                          radius: 80,
                          backgroundImage: FileImage(_image!),
                        ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _saveFullName(_fullNameController.text);
LocalStorage().setIsFirstTime(false);              },
              child: Text('Save Full'),
            ),
          ],
        ),
      ),
    );
  }
}
