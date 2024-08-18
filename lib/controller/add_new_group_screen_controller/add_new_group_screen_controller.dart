import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:drosak_m_app/model/groups/time_day_group_model.dart';
import 'package:flutter/cupertino.dart';

class AddNewGroupScreenController {
  String status = ConstValue.kAddNewGroup;

  TextEditingController controllerGroupDesc = TextEditingController();
  TextEditingController controllerGroupName = TextEditingController();
  GlobalKey<FormState> formStateGroupDetails = GlobalKey<FormState>();

  List<ItemStageModel> listItemStageModel = [];

  String? timeGroup;

  List<TimeDayGroupModel> listTimeDayGroupModel = [
  ];

  void getArgumentFromLastScreen(BuildContext context) {
    var arg = ModalRoute.of(context);
    if (arg != null) {
      String argument = arg.settings.arguments.toString();
      status = argument;
    }
  }

  onChangedSelectEducationStageName(ItemStageModel? p1) {}

  void onPressedSelectTime() {
  }

  onChangedSelectDay(String? p1) {
  }

  void onPressedAddTimeAndDayToTable() {
  }
}
