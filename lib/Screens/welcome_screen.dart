import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




import '../Authentication/login_screen.dart';
import '../Authentication/signup.dart';


class WelScreen extends StatefulWidget {
  const WelScreen({super.key});

  @override
  State<WelScreen> createState() => _WelScreenState();
}

class _WelScreenState extends State<WelScreen> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var brightness = mediaQuery.platformBrightness;
    var height = mediaQuery.size.height;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Image.asset('assets/img5.jpg', height: height * 0.5), //note
            Column(
              children: [

                Text("Welcome",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  "We are here for you",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)), backgroundColor: Colors.red.shade200,
                          minimumSize: Size(350, 40), //////// HERE
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (_) => SignInScreen()));

                        },

                        child: Text("Login".toUpperCase(),style: TextStyle(color: Colors.white)))),
                //note
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)), backgroundColor: Colors.red.shade200,
                          minimumSize: Size(350, 40), //////// HERE
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (_) => SignUpScreen()));

                        },

                        child: Text("Signup".toUpperCase(),style: TextStyle(color: Colors.white),))),
                //note
              ],
            )
          ],
        ),
      ),
    );
  }
}
