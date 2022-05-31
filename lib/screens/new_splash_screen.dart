import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:quraanproject/HomePage/home_page.dart';
import 'package:quraanproject/screens/onboarding_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({ Key? key }) : super(key: key);

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
        bool alreadyUsed=false; 
void getData()async{
final prefs = await SharedPreferences.getInstance();
alreadyUsed=prefs.getBool("alreadyUsed")?? false;

}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    getData();

    Timer(Duration(seconds: 4), () => Navigator.pushReplacement(context,
    MaterialPageRoute(builder: (context) {
      return alreadyUsed? HomePage(): OnBoardingScreen();})
    ),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:  AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          
          "HOLY QURAN",
          speed: Duration(milliseconds: 150),
          textStyle: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            fontFamily: "font4",
            // color: Color.fromARGB(255, 0, 7, 2)
          ),
        ),
      ],
      isRepeatingAnimation: false,
     
      ),),
    );
  }
}