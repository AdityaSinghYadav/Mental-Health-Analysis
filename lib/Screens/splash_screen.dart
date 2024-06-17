import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'onBoarding_screen.dart';
class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override


  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), (){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute
            (builder: (context) => OnboardingScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          margin: EdgeInsets.only(left: 25, right: 25),
          alignment: Alignment.center,
          child: Image.asset('assets/img1.jpg', width: 270, height: 270, )

      ),
    );
  }
}