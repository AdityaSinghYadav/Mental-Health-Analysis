import 'package:flutter/material.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../Screens/splash_screen.dart';
import 'core/services/hive.dart';
import 'core/services/notification.dart';
import 'core/utils/constants.dart';
import 'core/utils/routes.dart';


void main() async {
  await HiveService.init();


}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Tracker',
      debugShowCheckedModeBanner: false,
      navigatorKey: AppNavigator.navigatorKey,
      onGenerateRoute: AppNavigator.onGenerateRoute,
      home: SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
