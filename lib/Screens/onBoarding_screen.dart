import 'package:flutter/material.dart';
import 'package:healme/Screens/welcome_screen.dart';

import '../custom widget/AppColor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: OnboardingScreen());
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
      setState(() {
        _currentPage++;
      });
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => WelScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red.shade200,
        actions: [
          Container(
            child: TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => WelScreen()));
              },
              child: Text(
                'Skip',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                OnboardingPage(
                    image: "img2.jpg",
                    text:
                        'When you feel like talking,talk.\nWe Are Here To Listen!'),
                OnboardingPage(
                    image: "img3.jpg",
                    text: 'And when not,\nget Guided Medication.'),
                OnboardingPage(
                    image: "img4.jpg",
                    text:
                        'Ready to begin your journey?\nEmbark on a new path and find a better you!!'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(3, (int index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 8,
                width: _currentPage == index ? 30 : 10,
                margin: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? AppColors.tSecondaryColor
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              );
            }),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(48)),
              backgroundColor: Colors.red.shade200,
              minimumSize: Size(300, 30), //////// HERE
            ),
            onPressed: () {
              _nextPage();
            },
            child: Text(_currentPage < 2 ? 'Next' : 'Get Started',
                style: TextStyle(color: Colors.white)),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;
  final String text;

  OnboardingPage({required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/$image',
          fit: BoxFit.cover,
        ),
        Container(
          padding: EdgeInsets.only(bottom: 132),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
