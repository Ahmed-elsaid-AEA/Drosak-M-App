import 'dart:async';

import 'package:drosak_m_app/core/database/sqlite/education_stage_operation.dart';
import 'package:drosak_m_app/core/database/sqlite/groups_operation.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:drosak_m_app/model/groups/group_details.dart';
import 'package:drosak_m_app/model/groups/appointment_model.dart';
import 'package:drosak_m_app/model/groups/groups_info_model.dart';
import 'package:flutter/material.dart';

class AddNewGroupScreenController {
  String status = ConstValue.kAddNewGroup;
  String? selectedDay;
  TimeOfDay? selectedTime;
  GroupInfoModel? _groupInfoModel;
  ItemStageModel? selectedEducationStage;
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
  late StreamController<List<AppointmentModel>> controllerListTimeDayGroupModel;
  late Sink<List<AppointmentModel>> inputDataListTimeDayGroupModel;
  late Stream<List<AppointmentModel>> outPutDataListTimeDayGroupModel;

  ///steam of list Time Day Group Model
  late StreamController<ItemStageModel> controllerInitialItem;
  late Sink<ItemStageModel> inputPutDataInitialItem;
  late Stream<ItemStageModel> outPutDataInitialItem;

  List<ItemStageModel> listItemStageModel = [];
  String? timeGroup;

  List<AppointmentModel> listAppointmentGroupModel = [];

  String groupValueMS = ConstValue.kAM;

//! global variable  context
  BuildContext context;

  AddNewGroupScreenController(this.context) {
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

    ///init steam initial data
    controllerInitialItem = StreamController();
    inputPutDataInitialItem = controllerInitialItem.sink;
    outPutDataInitialItem = controllerInitialItem.stream.asBroadcastStream();
  }

  void initAllData() async {
    await getAllItemStageModelList();
    addNewValueOFMs();
    addNewValueOfSelectedTime();
    changeStatusOFStreamListTimeDay();
    print(_groupInfoModel == null);
    if (_groupInfoModel != null) {
      fillDataInEditStatus();
    }
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
    inputDataListTimeDayGroupModel.add(listAppointmentGroupModel);
  }

  void addNewValueOfSelectedTime() {
    if (selectedTime != null) {
      inputDataSelectedTime
          .add("${selectedTime!.minute} : ${selectedTime!.hour}");
    }
  }

  Future<void> getAllItemStageModelList() async {
    EducationStageOperation educationStageOperation = EducationStageOperation();
    listItemStageModel = await educationStageOperation.getAllEducationData();
    inputDataListItemStageModel.add(listItemStageModel);
  }

  void getArgumentFromLastScreen(BuildContext context) {
    var arg = ModalRoute.of(context);
    if (arg != null) {
      var arguments = arg.settings.arguments;
      if (arguments is Map) {
        //? now in status edit
        argumentsInEditStatus(arguments);
      } else {
        //? now in add new
        String argument = arguments.toString();
        status = argument;
      }
    }
  }

  void argumentsInEditStatus(Map arguments) {
    //?check if has status edit
    if (arguments.containsKey(ConstValue.kStatus)) {
      status = arguments[ConstValue.kStatus];
    }
    //?check if has kGroupInfoModel key
    if (arguments.containsKey(ConstValue.kGroupInfoModel)) {
      //check if was in type GroupInfoModel
      if (arguments[ConstValue.kGroupInfoModel] is GroupInfoModel) {
        _groupInfoModel = arguments[ConstValue.kGroupInfoModel];
      }
    }
  }

  void fillDataInEditStatus() {
    //?fill name
    controllerGroupName.text = _groupInfoModel!.groupDetails.name;
    //?fill desc
    controllerGroupDesc.text = _groupInfoModel!.groupDetails.desc;
    //?fill listAppointmentGroupModel
    listAppointmentGroupModel += _groupInfoModel!.listAppointment;
    //?send to input stream
    inputDataListTimeDayGroupModel.add(listAppointmentGroupModel);
    int stageID = _groupInfoModel!.groupDetails.educationStageID;

    List<ItemStageModel> listFound =
        listItemStageModel.where((element) => element.id == stageID).toList();

    if (listFound.isNotEmpty) {
      selectedEducationStage = listFound[0];
      print(selectedEducationStage);
      inputPutDataInitialItem.add(selectedEducationStage!);
    }
  }

  onChangedSelectEducationStageName(ItemStageModel? p1) {
    selectedEducationStage = p1;
  }

  void _closeKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void onPressedSelectTime() async {
    //?close keyboard
    _closeKeyboard();
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
    _closeKeyboard();
    listAppointmentGroupModel.add(AppointmentModel(
        ms: groupValueMS,
        time: "${selectedTime!.minute} : ${selectedTime!.hour}",
        day: selectedDay!));
    changeStatusOFStreamListTimeDay();
  }

  void onPressedDeleteAppointment(int index) {
    listAppointmentGroupModel.removeAt(index);
    changeStatusOFStreamListTimeDay();
    print(_groupInfoModel!.listAppointment);
  }

  String checkAllDataValidate() {
    String requiredData = "";
    if (controllerGroupName.text.trim().isEmpty) {
      requiredData += ConstValue.kNameGroup;
    }
    if (selectedEducationStage == null) {
      requiredData += " , ${ConstValue.kChooseEducationStage}";
    }
    if (listAppointmentGroupModel.isEmpty) {
      requiredData += " , ${ConstValue.kAddSomeAppointment}";
    }
    return requiredData;
  }

  void saveAllData(BuildContext context) async {
    String requiredData = checkAllDataValidate();
    if (requiredData.isEmpty) {
      //now add to database
      int groupId = await addDetailsOfGroups();
      if (groupId > 0) {
        if (await addDetailsOfAppointment(groupId)) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(ConstValue.kAddedGroupDetailsSucces)));
          backToMainScreen(context);
        }
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(requiredData)));
    }
  }

  Future<bool> addDetailsOfAppointment(int groupId) async {
    bool inserted = false;
    for (var appointmentItem in listAppointmentGroupModel) {
      GroupsOperation groupsOperation = GroupsOperation();
      inserted = await groupsOperation.insertAppointmentDetails(
          appointmentItem, groupId);
    }
    return inserted;
  }

  Future<int> addDetailsOfGroups() async {
    GroupsOperation groupsOperation = GroupsOperation();
    return groupsOperation.insertGroupDetails(GroupDetails(
        desc: controllerGroupDesc.text.trim(),
        name: controllerGroupName.text.trim(),
        educationStageID: selectedEducationStage!.id));
  }

  void backToMainScreen(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onPressedAtEditORSave() async {
    if (status == ConstValue.kEditThisGroup) {
      //?

      bool updated = await editIntoGroupInfo();
      if (updated == true) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(ConstValue.kAddedGroupDetailsSucces)));
        backToMainScreen(context);
      }
    } else {
      saveAllData(context);
    }
  }

  Future<bool> editIntoGroupInfo() async {
    String requiredData = checkAllDataValidate();
    if (requiredData.isEmpty) {
      //now add to database
      GroupsOperation groupsOperation = GroupsOperation();

      return groupsOperation.editEducationStage(
          GroupInfoModel(
              groupDetails: GroupDetails(
                  desc: controllerGroupDesc.text,
                  id: _groupInfoModel!.groupDetails.id,
                  name: controllerGroupName.text,
                  educationStageID: selectedEducationStage!.id),
              listAppointment: listAppointmentGroupModel),
          _groupInfoModel!.listAppointment);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(requiredData)));
      return false;
    }
  }
}
