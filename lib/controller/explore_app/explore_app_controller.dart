import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/routes_mananger.dart';
import 'package:flutter/cupertino.dart';

class ExploreAppController {
  void goToMainScreen({required int value, required BuildContext context}) {
    Navigator.of(context).pushNamed(RoutesName.kMainScreenRoute, arguments: {
      ConstValue.kScreenIndex: value,
    });
  }
}
