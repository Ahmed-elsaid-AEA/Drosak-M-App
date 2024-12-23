import 'dart:async';

import 'package:drosak_m_app/core/database/sqlite/audience_operation.dart';
import 'package:drosak_m_app/core/database/sqlite/education_stage_operation.dart';
import 'package:drosak_m_app/core/database/sqlite/groups_operation.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:drosak_m_app/model/groups/group_details.dart';
import 'package:drosak_m_app/model/student_model.dart';
import 'package:flutter/src/widgets/framework.dart';

class AudienceController {
  BuildContext context;

  ItemStageModel? selectedEducationStage;
  GroupDetails? selectedGroupDetails;

  ///steam of list initial selected item education stage
  late StreamController<ItemStageModel> _controllerInitialItemSelectedStage;
  late Sink<ItemStageModel> _inputPutDataInitialItemSelectedStage;
  late Stream<ItemStageModel> outPutDataInitialItemSelectedStage;

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
    List<StudentModel> student = await audienceOperation
        .getStudentInfoByGroupID(selectedGroupDetails!.id);

    print(student);
  }
}