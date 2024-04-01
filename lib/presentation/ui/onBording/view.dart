import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:concentric_transition/concentric_transition.dart';
import 'package:lottie/lottie.dart';
import 'package:money_app/presentation/ui/transactions/transactions_screen.dart';

class MyConcentricTransition extends StatelessWidget {
  MyConcentricTransition({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> lottieData = [
    {
      'asset': 'assets/Animation4.json',
      'text': 'Manage\nYour Finances\nEfficiently!',
      'textColor': Colors.black
    },
    {
      'asset': 'assets/Animation2.json',
      'text': 'Track\nYour Expenses\nwith Ease!',
      'textColor': Colors.black
    },
    {
      'asset': 'assets/Animation5.json',
      'text': 'Explore\nThe Beautiful\nWorld!',
      'textColor': Colors.white
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ConcentricPageView(
            radius: 40,
            verticalPosition: 0.85,
            colors: [Color(0xFFF0DCC3), Colors.white, const Color.fromARGB(255, 121, 203, 240)],
            nextButtonBuilder: (context) => Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Icon(Icons.navigate_next, size: 30),
            ),
            itemBuilder: (index) {
              final data = lottieData[index % lottieData.length];
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 200),
                    Center(
                      child: Lottie.asset(
                        data['asset'],
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        data['text'],
                        style: TextStyle(
                          color: data['textColor'],
                          fontSize: MediaQuery.of(context).size.width > 600 ? 18 : 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Exo',
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            top: 20,
            right: 10,
            child: TextButton(
              onPressed: () {
                Get.offAll(() => TransactionsScreen());
              },
              child: Text(
                'Skip',
                style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Exo'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
