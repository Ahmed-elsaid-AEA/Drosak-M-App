import 'package:drosak_m_app/core/resources/routes_mananger.dart';
import 'package:flutter/cupertino.dart';

class ExploreAppController {
  void goToMainScreen(
      {required String nameSections, required BuildContext context}) {
    Navigator.of(context).pushNamed(RoutesName.kMainScreen);
  }
}
