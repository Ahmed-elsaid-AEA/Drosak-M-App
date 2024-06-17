import 'package:drosak_m_app/view/splash_screen/screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';

class RoutesManager{
 static Map<String, WidgetBuilder> routes={
    RoutesName.kSplashScreen:(context) => const SplashScreen()
  };
}class RoutesName{
  static const String kSplashScreen='/kSplashScreen';
}