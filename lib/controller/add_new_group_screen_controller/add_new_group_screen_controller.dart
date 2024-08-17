import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:flutter/cupertino.dart';

class AddNewGroupScreenController {
  String status = ConstValue.kAddNewGroup;

  void getArgumentFromLastScreen(BuildContext context) {
    var arg = ModalRoute.of(context);
    if (arg != null) {
      String argument = arg.settings.arguments.toString();
      status = argument;
    }
  }
}
