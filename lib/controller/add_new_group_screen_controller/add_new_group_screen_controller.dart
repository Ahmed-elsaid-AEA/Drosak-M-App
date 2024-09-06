import 'dart:async';

import 'package:drosak_m_app/core/database/sqlite/education_stage_operation.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:drosak_m_app/model/groups/time_day_group_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewGroupScreenController {
  String status = ConstValue.kAddNewGroup;
  String? selectedDay;
  TimeOfDay? selectedTime;
  TextEditingController controllerGroupDesc = TextEditingController();
  TextEditingController controllerGroupName = TextEditingController();
  GlobalKey<FormState> formStateGroupDetails = GlobalKey<FormState>();

  ///steam of education stage screen
  late StreamController<List<ItemStageModel>> controllerListItemStageModel;
  late Sink<List<ItemStageModel>> inputDataListItemStageModel;
  late Stream<List<ItemStageModel>> outPutDataListItemStageModel;

  ///steam of selected MS value
  late StreamController<String> controllerMsValue;
  late Sink<String> inputDataMsValue;
  late Stream<String> outPutDataMsValue;
  List<ItemStageModel> listItemStageModel = [];
  String? timeGroup;

  List<TimeDayGroupModel> listTimeDayGroupModel = [
    TimeDayGroupModel("jkad", "dsa", "sd")
  ];

  String groupValueMS = ConstValue.kAM;

  AddNewGroupScreenController() {
    start();
  }

  void start() async {
    await initControllers();
    initAllData();
  }

  Future<void> initControllers() async {
    ///init steam of education stage screen
    controllerListItemStageModel = StreamController();
    inputDataListItemStageModel = controllerListItemStageModel.sink;
    outPutDataListItemStageModel = controllerListItemStageModel.stream;

    ///init steam of selected MS value
    controllerMsValue = StreamController();
    inputDataMsValue = controllerMsValue.sink;
    outPutDataMsValue = controllerMsValue.stream;
  }

  void initAllData() {
    getAllItemStageModelList();
    addNewValueOFMs();
  }

//?
  void addNewValueOFMs() {
    inputDataMsValue.add(groupValueMS);
  }

  void getAllItemStageModelList() async {
    EducationStageOperation educationStageOperation = EducationStageOperation();
    listItemStageModel = await educationStageOperation.getAllEducationData();
    inputDataListItemStageModel.add(listItemStageModel);
  }

  void getArgumentFromLastScreen(BuildContext context) {
    var arg = ModalRoute.of(context);
    if (arg != null) {
      String argument = arg.settings.arguments.toString();
      status = argument;
    }
  }

  onChangedSelectEducationStageName(ItemStageModel? p1) {}

  void onPressedSelectTime(BuildContext context) async {
    TimeOfDay? time = await showTimePicker(
        barrierDismissible: false,
        cancelText: ConstValue.kCancel,
        confirmText: ConstValue.kChoose,
        helpText: ConstValue.kChooseTime,
        context: context,
        initialTime: const TimeOfDay(hour: 1, minute: 10));
    if (time != null) {
      selectedTime = time;
      print(selectedTime);
    }
  }

  onChangedSelectDay(String? day) {
    selectedDay = day;
  }

  void onPressedAddTimeAndDayToTable() {}

  void onChangedMSValue(String? value) {
    if (value != null) groupValueMS = value;
    addNewValueOFMs();
  }

  Future<void> disposeControllers() async {
    controllerListItemStageModel.close();
    inputDataListItemStageModel.close();
  }
}
