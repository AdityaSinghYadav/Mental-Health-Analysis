import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/services/hive.dart';
import '../../core/utils/assets.dart';
import '../../core/utils/routes.dart';
import '../widgets/app_text.dart';
import '../widgets/default_container.dart';


class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    scheduleMicrotask(() async {
      await Future.delayed(const Duration(milliseconds: 3200));
      await AppNavigator.replaceWith(
        HiveService.getSettings().skipIntroduction ?
          Routes.main : Routes.introduction
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: DefaultContainer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(AppAssets.animatedHi),
               AppText(
                text: 'ヾ(＾∇＾)',
                weight: FontWeight.bold,
                size: 28,
              ),
              AppText(
                text: 'NiHao 你好',
                weight: FontWeight.bold,
                size: 28,
              ),
            ],
          ),
        )
      ),
    );
  }
}