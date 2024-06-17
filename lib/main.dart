import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:healme/provider/auth.dart';
import 'package:healme/provider/cloudstore.dart';
import 'package:provider/provider.dart';
import 'Mood/core/utils/routes.dart';
import 'Screens/splash_screen.dart';
import 'Screens/welcome_screen.dart';



List<CameraDescription>? cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyApIu8QIHcNeFP_k59PiRQyjs5G5rZcskU",
      appId: "1:406582821668:android:d806abb004811a5430a9b1",
      messagingSenderId: "XXX",
      projectId: "heal-me-46d89",
    ),
  );

  runApp(
    MultiProvider(
      providers: [

        ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
        ChangeNotifierProvider<CloudstoreProvider>(create: (context) => CloudstoreProvider()),
      ],
      child: const ARTherapy(),
    ),
  );
}

class ARTherapy extends StatelessWidget {
  const ARTherapy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Mood Tracker',
        debugShowCheckedModeBanner: false,
        navigatorKey: AppNavigator.navigatorKey,
        onGenerateRoute: AppNavigator.onGenerateRoute,
        builder: EasyLoading.init(),
        theme: ThemeData(
        brightness: Brightness.light,
        // primaryColor: Colors.cyan[300],
        primaryColor: const Color(0xFF7D96E6),
        
        fontFamily: 'ProductSans',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            // fontFamily: 'Montserrat',
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7D96E6),
          ),
          displayMedium: TextStyle(
            fontSize: 28.0,
            color: Color(0xFF7D96E6),
          ),
          displaySmall: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF7D96E6),
          ),
          bodyLarge: TextStyle(fontSize: 21.0), // old: 26
          bodyMedium: TextStyle(fontSize: 18.0,color: Colors.black), // old: 22
          bodySmall: TextStyle(fontSize: 16.0),
        ),
        iconTheme: const IconThemeData(
          size: 28,
          color: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(22.0),
          ),
        ),
      ),
      home: SplashScreen()
    );
  }
}
