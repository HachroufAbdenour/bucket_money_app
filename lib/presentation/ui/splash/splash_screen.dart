import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:money_app/presentation/ui/splash/splash_controller.dart';
import 'package:money_app/shared/localization/keys.dart';
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent, // Set background color to blueAccent
      body: GetBuilder<SplashController>(
        init: SplashController(), // Initialize the SplashController
        builder: (_) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.blueAccent, // Set container color to blueAccent
                  child: Lottie.asset(
                    'assets/lotties/Animationmoney.json', // Path to your Lottie animation file
                    width: 300,
                    height: 300,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20), // Add some spacing between the Lottie animation and the text
                Text(
                  StringsKeys.moneyApp, // Your app name
                  style: TextStyle(
                    color: Colors.white, // Set text color to white
                    fontSize:30, // Adjust font size as needed
                    fontWeight: FontWeight.bold, // Apply bold font weight
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
