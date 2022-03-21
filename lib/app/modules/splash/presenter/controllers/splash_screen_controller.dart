import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../app_module.dart';

class SplashScreenController {
  late final AnimationController splashIconAnimationController;

  void initAnimationController(TickerProvider page){
    splashIconAnimationController = AnimationController(
        vsync: page,
        duration: const Duration(milliseconds: 1500),
        lowerBound: 0.5
    )..repeat();
  }

  void disposeAnimationController(){
    splashIconAnimationController.dispose();
  }

  run() async {
    await Future.delayed(const Duration(seconds: 4));
    await Modular.to.pushReplacementNamed(AppModule.homePageRouteName);
  }
}