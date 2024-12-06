import 'package:drosak_m_app/view/add_new_group_screen/add_new_group_screen.dart';
import 'package:drosak_m_app/view/add_new_student_screen/add_new_student_screen.dart';
import 'package:drosak_m_app/view/audience/screens/audience_screen.dart';
import 'package:drosak_m_app/view/education_stages/screens/education_stages_screen.dart';
import 'package:drosak_m_app/view/explore_app/screens/explore_app_screen.dart';
import 'package:drosak_m_app/view/groups/screens/groups_screen.dart';
import 'package:drosak_m_app/view/main_screen/main_screen.dart';
import 'package:drosak_m_app/view/on_boarding/screen/on_boarding_screen.dart';
import 'package:drosak_m_app/view/paying/screens/paying_screen.dart';
import 'package:drosak_m_app/view/splash_screen/screens/splash_screen.dart';
import 'package:drosak_m_app/view/students/screens/students_screen.dart';
import 'package:flutter/cupertino.dart';

class RoutesManager {
  static Map<String, WidgetBuilder> routes = {
    RoutesName.kSplashScreenRoute: (context) => const SplashScreen(),
    RoutesName.kOnBoardingScreenRoute: (context) => const OnBoardingScreen(),
    RoutesName.kMainScreenRoute: (context) => const MainScreen(),
    RoutesName.kExploreAppScreenRoute: (context) => const ExploreAppScreen(),
    RoutesName.kGroupsRoute: (context) => const GroupsScreen(),
    RoutesName.kAudienceRoute: (context) => const AudienceScreen(),
    RoutesName.kStudentsRoute: (context) => const StudentsScreen(),
    RoutesName.kEducationStagesRoute: (context) =>
        const EducationStagesScreen(),
    RoutesName.kPayingRoute: (context) => const PayingScreen(),
    RoutesName.kAddNewGroupScreen: (context) => const AddNewGroupScreen(),
    RoutesName.kAddNewStudentsScreen: (context) => const AddNewStudentsScreen(),
  };
}

class RoutesName {
  static const String kSplashScreenRoute = '/kSplashScreenRoute';
  static const String kOnBoardingScreenRoute = '/kOnBoardingScreenRoute';
  static const String kExploreAppScreenRoute = '/kExploreAppScreenRoute';
  static const String kMainScreenRoute = '/kMainScreenRoute';
  static const String kPayingRoute = '/kPayingRoute';
  static const String kEducationStagesRoute = '/kEducationStagesRoute';
  static const String kAudienceRoute = '/kAudienceRoute';
  static const String kGroupsRoute = '/kGroupsRoute';
  static const String kStudentsRoute = '/kMainScreen';
  static const String kAddNewGroupScreen = '/kAddNewGroupScreen';
  static const String kAddNewStudentsScreen = '/kAddStudentsScreen';
}
