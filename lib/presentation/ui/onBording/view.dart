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
import 'package:money_app/shared/styles/colors.dart';


void getImage(File? _image, Function(File) setImage) async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    final image = File(pickedFile.path);
    setImage(image);
    GetStorage().write('image', pickedFile.path); // Save image path to storage
  } else {
    print('No image selected.');
  }
}
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
          OnboardingPage3(),
              OnboardingPage4(),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
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
        color: isActive ? Colors.white : Color.fromARGB(255, 225, 220, 220),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class OnboardingPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
       color: Colors.white,
         child: Center(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                         SizedBox(height: 40,),

              Text("Money Manangement ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.black),),
             SizedBox(height: 30,),
              Center( 
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.only(top: 30),
                  height: 350,
                  width: 300,
                  decoration: BoxDecoration(  
                    
                  borderRadius: BorderRadius.circular(20),
        color:  AppColors.primary,
                ),
                child: Column(
                  children: [
                
                Text("Gettings Started ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22 ),),
                SizedBox(height: 30,),
                Text("Follow all the steps to complete ",style: TextStyle(color: Colors.white,fontSize: 14 ),),
                Text("the verification process",style: TextStyle(color: Colors.white,fontSize: 14 ),),
                SizedBox(height: 20,),
                Text("this will help us confirm ",style: TextStyle(color: Colors.white,fontSize: 14 ),),
                Text("its really You ",style: TextStyle(color: Colors.white,fontSize: 14 ),),
                
                
                SizedBox(height: 40,),
                
             ElevatedButton(
            onPressed: () {
              // Add your onPressed functionality here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              'Start >',
              style: TextStyle(fontSize: 20),
            ),
          ),


                
                
                
                  ],
                ),
                ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class OnboardingPage2 extends StatefulWidget {
  @override
  State<OnboardingPage2> createState() => OnboardingPage2State();
}

class OnboardingPage2State extends State<OnboardingPage2> {
  final TextEditingController _fullNameController = TextEditingController();
  File? _image;
  final _storage = GetStorage();

 

  void _saveFullName(String fullName) {
    _storage.write('fullName', fullName); // Save full name to storage
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color:  AppColors.primary,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Enter your full name",
                  style: TextStyle(color: Colors.white,fontSize: 25, fontWeight: FontWeight.bold,),
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
             
                  
                     ElevatedButton(
            onPressed: () {
   _saveFullName(_fullNameController.text);
                  LocalStorage().setIsFirstTime(false);                 },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              'Save >',
              style: TextStyle(fontSize: 20),
            ),
          ),

              
             
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class OnboardingPage3 extends StatefulWidget {
  @override
  OnboardingPage3State createState() => OnboardingPage3State();
}

class OnboardingPage3State extends State<OnboardingPage3> {
  final TextEditingController _fullNameController = TextEditingController();
  File? _image;
  final _storage = GetStorage();

 

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      
        child: Container(
          color:  Color.fromARGB(255, 0, 242, 255),
          child: Center(
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Row(children: [

         Center(
           child: Text(
                    "Select  Profile",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
         ),

                IconButton(onPressed:(){}, icon: Icon(Icons.folder,color: Colors.white,size: 20,),),
       
              ],),
                SizedBox(height: 15),
             
        
        
              GestureDetector(
                  onTap: () {
                    getImage(_image, (image) {
                      setState(() {
                        _image = image;
                      });
                    });
                  },
                  child: Container(
                    color: AppColors.primary,
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
        LocalStorage().setIsFirstTime(false);              },
                  child: Text('Save Full'),
                ),
              ],
            ),
          ),
        ),
      
    );
  }
}


class OnboardingPage4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.blue,
        child: Column(
          children: [
            Text("Authentication succussfull ",                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
),
            Center( 
              child: Lottie.asset('assets/Animationa.json', width: 400),
            ),
          ],
        ),
      ),
    );
  }
}
