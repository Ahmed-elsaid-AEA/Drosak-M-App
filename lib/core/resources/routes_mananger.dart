import 'package:drosak_m_app/view/explore_app/screens/explore_app_screen.dart';
import 'package:drosak_m_app/view/on_boarding/screen/on_boarding_screen.dart';
import 'package:drosak_m_app/view/splash_screen/screens/splash_screen.dart';
import 'package:flutter/cupertino.dart';

class RoutesManager {
  static Map<String, WidgetBuilder> routes = {
    RoutesName.kSplashScreen: (context) => const SplashScreen(),
    RoutesName.kOnBoardingScreen: (context) => const OnBoardingScreen(),
    RoutesName.kExploreAppScreenRoute: (context) => const ExploreAppScreen(),
  };
}

class RoutesName {
  static const String kSplashScreen = '/kSplashScreen';
  static const String kOnBoardingScreen = '/kOnBoardingScreen';
  static const String kExploreAppScreenRoute = '/kExploreAppScreen';
}
