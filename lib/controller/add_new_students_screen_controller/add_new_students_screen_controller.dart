import 'dart:async';

import 'package:drosak_m_app/core/database/sqlite/education_stage_operation.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:drosak_m_app/model/groups/appointment_model.dart';
import 'package:flutter/material.dart';

class AddNewStudentsScreenController {
  String status = ConstValue.kAddNewStudent;
  late StreamController<String?> controllerPathImage;
  late Sink<String?> inputPathImage;
  late Stream<String?> outPutPathImage;

  TextEditingController controllerStudentNote = TextEditingController();
  TextEditingController controllerStudentName = TextEditingController();
  GlobalKey<FormState> formStateStudentDetails = GlobalKey<FormState>();

  ItemStageModel? selectedEducationStage;

  ///steam of education stage screen
  late StreamController<List<ItemStageModel>> controllerListItemStageModel;
  late Sink<List<ItemStageModel>> inputDataListItemStageModel;
  late Stream<List<ItemStageModel>> outPutDataListItemStageModel;

  ///steam of list Time Day Group Model
  late StreamController<List<AppointmentModel>> controllerListTimeDayGroupModel;
  late Sink<List<AppointmentModel>> inputDataListTimeDayGroupModel;
  late Stream<List<AppointmentModel>> outPutDataListTimeDayGroupModel;

  ///steam of list Time Day Group Model
  late StreamController<ItemStageModel> controllerInitialItem;
  late Sink<ItemStageModel> inputPutDataInitialItem;
  late Stream<ItemStageModel> outPutDataInitialItem;

  List<ItemStageModel> listItemStageModel = [];

//! global variable  context
  BuildContext context;

  AddNewStudentsScreenController(this.context) {
    start();
  }

  void start() async {
    await initControllers();
    initAllData();
  }

  Future<void> initControllers() async {
    ///init stream of image students
    controllerPathImage = StreamController();
    inputPathImage = controllerPathImage.sink;
    outPutPathImage = controllerPathImage.stream.asBroadcastStream();

    ///init steam of education stage screen
    controllerListItemStageModel = StreamController();
    inputDataListItemStageModel = controllerListItemStageModel.sink;
    outPutDataListItemStageModel =
        controllerListItemStageModel.stream.asBroadcastStream();

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
  }

  void disposeControllers() {
    ///dispose steam of education stage screen
    controllerListItemStageModel.close();
    inputDataListItemStageModel.close();

    ///dispose steam of List Time Day Group Model
    controllerListTimeDayGroupModel.close();
    inputDataListTimeDayGroupModel.close();
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
      } else {
        //? now in add new
        String argument = arguments.toString();
        status = argument;
      }
    }
  }

  onChangedSelectEducationStageName(ItemStageModel? p1) {
    selectedEducationStage = p1;
  }

  void _closeKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void backToMainScreen(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onPressedAtEditORSave() async {
    if (status == ConstValue.kEditThisStudent) {
      //TODO:// now edit
      /*  bool updated = await editIntoGroupInfo();
      if (updated == true) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(ConstValue.kAddedGroupDetailsSucces)));
        backToMainScreen(context);
      }*/
    } else {
      //TODO://save data
    }
  }
}
