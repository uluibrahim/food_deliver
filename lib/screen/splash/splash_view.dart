import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_deliver/core/navigator/navigator_manager.dart';
import 'package:food_deliver/screen/on_board/view/on_board_view.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with NavigatorManager {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1600), () async {
      navigateReplaceToWidget(context, const OnBoardView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Lottie.asset("assets/json/animation_splash.json")),
    );
  }
}
