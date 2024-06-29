import 'package:drosak_m_app/core/resources/routes_mananger.dart';
import 'package:flutter/material.dart';

class SplashScreenController {
  late AnimationController _animationController;
  late Animation<Offset> animationBottom;
  late Animation<Offset> animationTop;
final BuildContext context;
  final TickerProvider vsync;
  SplashScreenController(this.context,this.vsync) {
    initController();
  }

  void initController() {
    startAnimation();
  }

  void disposeController(){
    _animationController.dispose();
  }
  void startAnimation() {
    _animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(seconds: 1),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          goToOnBoardingScreen();
        }
      });
    animationBottom = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    animationTop = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _animationController.forward();
  }

  void goToOnBoardingScreen() {
    Navigator.pushReplacementNamed(context, RoutesName.kOnBoardingScreenRoute);
  }
}
