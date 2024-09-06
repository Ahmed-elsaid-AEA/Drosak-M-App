import 'dart:async';

import 'package:drosak_m_app/core/database/sqlite/education_stage_operation.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:drosak_m_app/model/groups/time_day_group_model.dart';
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

  ///steam of selected Time
  late StreamController<String> controllerSelectedTime;
  late Sink<String> inputDataSelectedTime;
  late Stream<String> outPutDataSelectedTime;

  ///steam of list Time Day Group Model
  late StreamController<List<TimeDayGroupModel>>
      controllerListTimeDayGroupModel;
  late Sink<List<TimeDayGroupModel>> inputDataListTimeDayGroupModel;
  late Stream<List<TimeDayGroupModel>> outPutDataListTimeDayGroupModel;

  List<ItemStageModel> listItemStageModel = [];
  String? timeGroup;

  List<TimeDayGroupModel> listTimeDayGroupModel = [];

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
    outPutDataListItemStageModel =
        controllerListItemStageModel.stream.asBroadcastStream();

    ///init steam of selected MS value
    controllerMsValue = StreamController();
    inputDataMsValue = controllerMsValue.sink;
    outPutDataMsValue = controllerMsValue.stream.asBroadcastStream();

    ///init steam of selected Time
    controllerSelectedTime = StreamController();
    inputDataSelectedTime = controllerSelectedTime.sink;
    outPutDataSelectedTime = controllerSelectedTime.stream.asBroadcastStream();

    ///init steam of List Time Day Group Model
    controllerListTimeDayGroupModel = StreamController();
    inputDataListTimeDayGroupModel = controllerListTimeDayGroupModel.sink;
    outPutDataListTimeDayGroupModel =
        controllerListTimeDayGroupModel.stream.asBroadcastStream();
  }

  void initAllData() {
    getAllItemStageModelList();
    addNewValueOFMs();
    addNewValueOfSelectedTime();
    changeStatusOFStreamListTimeDay();
  }

  void disposeControllers() {
    ///dispose steam of education stage screen
    controllerListItemStageModel.close();
    inputDataListItemStageModel.close();

    ///dispose steam of selected MS value
    controllerMsValue.close();
    inputDataMsValue.close();

    ///dispose steam of selected Time
    controllerSelectedTime.close();
    inputDataSelectedTime.close();

    ///dispose steam of List Time Day Group Model
    controllerListTimeDayGroupModel.close();
    inputDataListTimeDayGroupModel.close();
  }

//?
  void addNewValueOFMs() {
    inputDataMsValue.add(groupValueMS);
  }

  void changeStatusOFStreamListTimeDay() {
    inputDataListTimeDayGroupModel.add(listTimeDayGroupModel);
  }

  void addNewValueOfSelectedTime() {
    if (selectedTime != null) {
      inputDataSelectedTime
          .add("${selectedTime!.minute} : ${selectedTime!.hour}");
    }
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
      addNewValueOfSelectedTime();
    }
  }

  onChangedSelectDay(String? day) {
    selectedDay = day;
  }

  void onPressedAddTimeAndDayToTable(BuildContext context) {
    String requiredData = "";
    if (selectedDay == null) requiredData += ConstValue.kChooseDay;
    if (selectedTime == null) requiredData += " , ${ConstValue.kChooseTime}";
    if (requiredData.isEmpty) {
      //now you can add to table
      addTimeAndDayToTable();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(requiredData)));
    }
  }

  void onChangedMSValue(String? value) {
    if (value != null) groupValueMS = value;
    addNewValueOFMs();
  }

  void addTimeAndDayToTable() {
    listTimeDayGroupModel.add(TimeDayGroupModel(groupValueMS,
        "${selectedTime!.minute} : ${selectedTime!.hour}", selectedDay!));
    changeStatusOFStreamListTimeDay();
  }

  void onPressedDeleteAppointment(int index) {
    listTimeDayGroupModel.removeAt(index);
    changeStatusOFStreamListTimeDay();
  }
}
