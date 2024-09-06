import 'dart:async';

import 'package:drosak_m_app/core/database/sqlite/groups_operation.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/routes_mananger.dart';
import 'package:drosak_m_app/model/groups/appointment_model.dart';
import 'package:drosak_m_app/model/groups/group_details.dart';
import 'package:flutter/material.dart';

class GroupsScreenController {
  late StreamController<List> controllerListItemGroupModel;
  late Sink<List> inputDataListItemGroupModel;
  late Stream<List> outPutDataListItemGroupModel;

  GroupsScreenController() {
    start();
  }

  void start() async {
    await initControllers();
  }

  void initAllData() {
    inputDataListItemGroupModel.add([]);
  }

  Future<void> initControllers() async {
    controllerListItemGroupModel = StreamController();
    inputDataListItemGroupModel = controllerListItemGroupModel.sink;
    outPutDataListItemGroupModel = controllerListItemGroupModel.stream;
  }

  Future<void> disposeControllers() async {
    controllerListItemGroupModel.close();
    inputDataListItemGroupModel.close();
  }

  void addNewGroups({required BuildContext context}) {
    Navigator.of(context).pushNamed(RoutesName.kAddNewGroupScreen,
        arguments: ConstValue.kAddNewGroup);
  }

  Future<List<GroupDetails>> getGroupsDetailsFromDataBase() async {
    GroupsOperation groupsOperation = GroupsOperation();
    return groupsOperation.getAllGroupsData();
  }Future getAppointmentDetailsFromDataBase() async {
    GroupsOperation groupsOperation = GroupsOperation();

     var a=await groupsOperation.getAllAppointmentData();
     print(a);
  }

// Stream<List<ItemStageModel>> outPutDataListItemStageModel;
}
