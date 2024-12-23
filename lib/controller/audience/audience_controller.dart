import 'dart:async';

import 'package:drosak_m_app/core/database/sqlite/audience_operation.dart';
import 'package:drosak_m_app/core/database/sqlite/education_stage_operation.dart';
import 'package:drosak_m_app/core/database/sqlite/groups_operation.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/model/audience/audience_model.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:drosak_m_app/model/groups/group_details.dart';
import 'package:drosak_m_app/model/student_model.dart';
import 'package:drosak_m_app/view/audience/widgets/custom_add_new_audience_screen.dart';
import 'package:drosak_m_app/view/education_stages/widgets/body/custom_add_new_eudcation_stage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class AudienceController {
  BuildContext context;
  Map<String, bool?> mapSelectedStudent = {};
  ItemStageModel? selectedEducationStage;
  GroupDetails? selectedGroupDetails;
  DateTime? selectDate;

  ///steam of list initial selected item education stage
  late StreamController<ItemStageModel> _controllerInitialItemSelectedStage;
  late Sink<ItemStageModel> _inputPutDataInitialItemSelectedStage;
  late Stream<ItemStageModel> outPutDataInitialItemSelectedStage;

  ///steam of list initial selected item education stage
  late StreamController<Map<String, bool?>>
      _controllerInitialMapSelectedStudent;
  late Sink<Map<String, bool?>> _inputPutDataInitialMapSelectedStudent;
  late Stream<Map<String, bool?>> _outPutDataInitialMapSelectedStudent;

  ///steam of item education stage screen
  late StreamController<List<ItemStageModel>> _controllerListItemStageModel;
  late Sink<List<ItemStageModel>> _inputDataListItemStageModel;
  late Stream<List<ItemStageModel>> outPutDataListItemStageModel;

  ///steam of groups
  late StreamController<List<GroupDetails>> _controllerListItemGroupsDetails;
  late Sink<List<GroupDetails>> _inputDataListItemGroupsDetails;
  late Stream<List<GroupDetails>> outPutDataListItemGroupsDetails;

  ///steam of initial Selected Group
  late StreamController<GroupDetails?> _controllerInitialItemSelectedGroup;
  late Sink<GroupDetails?> _inputPutDataInitialItemSelectedGroup;
  late Stream<GroupDetails?> outPutDataInitialItemSelectedGroup;

  List<ItemStageModel> listItemStageModel = [];
  List<StudentModel> listStudentModel = [];

  AudienceController(this.context) {
    start();
  }

  void start() async {
    await initControllers();
    await initAllData();
  }

  Future<void> initAllData() async {
    await getAllItemStageModelList();
  }

  Future<void> getAllItemStageModelList() async {
    EducationStageOperation educationStageOperation = EducationStageOperation();
    listItemStageModel = await educationStageOperation.getAllEducationData();
    _inputDataListItemStageModel.add(listItemStageModel);
  }

  Future<void> getGroupsByEducationStageName() async {
    GroupsOperation groupsOperation = GroupsOperation();
    List<GroupDetails> listGroup =
        await groupsOperation.getGroupInnerJoinEducationStage(
            educationID: selectedEducationStage!.id);
    selectedGroupDetails = null;
    _inputPutDataInitialItemSelectedGroup.add(selectedGroupDetails);
    _inputDataListItemGroupsDetails.add(listGroup);
    if (listGroup.isNotEmpty) {
      selectedGroupDetails = listGroup[0];
      _inputPutDataInitialItemSelectedGroup.add(selectedGroupDetails);
    }
  }

  Future<void> initControllers() async {
    ///init steam of item education stage screen
    _controllerListItemStageModel = StreamController();
    _inputDataListItemStageModel = _controllerListItemStageModel.sink;
    outPutDataListItemStageModel =
        _controllerListItemStageModel.stream.asBroadcastStream();

    ///init steam _controllerInitialMapSelectedStudent
    _controllerInitialMapSelectedStudent = StreamController();
    _inputPutDataInitialMapSelectedStudent =
        _controllerInitialMapSelectedStudent.sink;
    _outPutDataInitialMapSelectedStudent =
        _controllerInitialMapSelectedStudent.stream.asBroadcastStream();

    ///init steam initial data item selected education stage
    _controllerInitialItemSelectedStage = StreamController();
    _inputPutDataInitialItemSelectedStage =
        _controllerInitialItemSelectedStage.sink;
    outPutDataInitialItemSelectedStage =
        _controllerInitialItemSelectedStage.stream.asBroadcastStream();

    ///init steam groups model
    _controllerListItemGroupsDetails = StreamController();
    _inputDataListItemGroupsDetails = _controllerListItemGroupsDetails.sink;
    outPutDataListItemGroupsDetails =
        _controllerListItemGroupsDetails.stream.asBroadcastStream();

    ///init steam intial groups model
    _controllerInitialItemSelectedGroup = StreamController();
    _inputPutDataInitialItemSelectedGroup =
        _controllerInitialItemSelectedGroup.sink;
    outPutDataInitialItemSelectedGroup =
        _controllerInitialItemSelectedGroup.stream.asBroadcastStream();
  }

  void disposeControllers() {
    ///dispose stream of item education stage screen
    _controllerListItemStageModel.close();
    _inputDataListItemStageModel.close();

    ///dispose steam of List  item education stage screen
    _controllerInitialItemSelectedStage.close();
    _inputPutDataInitialItemSelectedStage.close();

    ///dispose steam of List  Groups Details Model
    _controllerListItemGroupsDetails.close();
    _inputDataListItemGroupsDetails.close();

    ///dispose steam of List  Groups Details Model
    _controllerInitialItemSelectedGroup.close();
    _inputPutDataInitialItemSelectedGroup.close();

    ///dispose _controllerInitialMapSelectedStudent
    _controllerInitialMapSelectedStudent.close();
    _inputPutDataInitialMapSelectedStudent.close();
  }

  void onChangedSelectEducationStageName(ItemStageModel? p1) {
    selectedEducationStage = p1;
    if (selectedEducationStage != null) getGroupsByEducationStageName();
  }

  onChangedSelectGroupsName(GroupDetails? p1) {
    selectedGroupDetails = p1;
    if (selectedGroupDetails != null) getStudentInfo();
  }

  Future<void> getStudentInfo() async {
    AudienceOperation audienceOperation = AudienceOperation();
    listStudentModel = await audienceOperation
        .getStudentInfoByGroupID(selectedGroupDetails!.id);
  }

  void onPressedAdd() async {
    if (selectedEducationStage == null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(ConstValue.kSelectEducationStage)));
    } else if (selectedGroupDetails == null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(ConstValue.kSelectGroups)));
    } else {
      mapSelectedStudent = {};
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return CustomAddNewAudienceScreen(
            onPressedAdd: onPressedAddToDataBase,
            listStudentModel: listStudentModel,
            outPutMapSelectedStudent: _outPutDataInitialMapSelectedStudent,
            onChangedSelectedStatus: changeSelectedStudentStatus,
            onPressedSelectedDateTime: onPressedSelectedDateTime,
          );
        },
      );
    }
  }

  void changeSelectedStudentStatus({required int id, required bool status}) {
    mapSelectedStudent[id.toString()] = status;
    _inputPutDataInitialMapSelectedStudent.add(mapSelectedStudent);
  }

  void onPressedSelectedDateTime() async {
    selectDate = await showDatePicker(
        context: context,
        lastDate: DateTime.now(),
        firstDate: DateTime.now().subtract(const Duration(days: 365)));
  }

  void onPressedAddToDataBase() async {
    await insertIntoDatabase();
    Navigator.of(context).pop();
  }

  Future<void> insertIntoDatabase() async {
    List<MapEntry<String, bool?>> data = mapSelectedStudent.entries
        .where((element) => element.value == true)
        .toList();
    selectDate ??= DateTime.now();
    for (int i = 0; i < data.length; i++) {
      AudienceOperation audienceOperation = AudienceOperation();
      await audienceOperation.insertNewAudience(AudienceModel(
          status: data[i].value.toString(),
          studentID: int.parse(data[i].key),
          selectedTimeData: selectDate.toString()));
    }
  }
}
