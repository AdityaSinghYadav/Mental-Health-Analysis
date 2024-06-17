import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healme/Explore/calendar.dart';
import 'package:healme/Mood/ui/screens/main.dart';
import '../custom widget/patient_info.dart';
import '../Julie/chatbot.dart';
import '../asessment/assesment_screen.dart';

class Homescreen extends StatefulWidget {
  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    ChatBot(),
    MainScreen(),
    Assessment(),
  ];

  void getCredentials() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc('${PatientInfo.email}')
        .get();
    setState(() {
      PatientInfo.name = doc['name'];
      PatientInfo.name = doc['friend'];
      PatientInfo.email = doc['friendContact'];
      PatientInfo.phone = doc['friendPhone'];
      PatientInfo.weight = doc['specialist'];
      PatientInfo.password = doc['specialistContact'];
    });
  }

  @override
  void initState() {
    super.initState();
    getCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        backgroundColor: Colors.transparent,
        height: 50.0,
        color: Colors.red.shade200,
        buttonBackgroundColor: Colors.red.shade200,
        items: [
          Icon(Icons.home, size: 30,color: Colors.white),
          Icon(Icons.explore, size: 30,color: Colors.white,),
          Icon(Icons.assessment, size: 30,color: Colors.white,),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
