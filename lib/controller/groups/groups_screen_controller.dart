import 'dart:async';
import 'package:drosak_m_app/core/database/sqlite/groups_operation.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/routes_mananger.dart';
import 'package:drosak_m_app/model/groups/groups_info_model.dart';
import 'package:flutter/material.dart';

class GroupsScreenController {
  late StreamController<List<GroupInfoModel>> controllerListItemGroupModel;
  late Sink<List<GroupInfoModel>> inputDataListItemGroupModel;
  late Stream<List<GroupInfoModel>> outPutDataListItemGroupModel;
  List<GroupInfoModel> listGroupInfo = [];

  GroupsScreenController() {
    start();
  }

  void start() async {
    await initControllers();
    await getAllData();
  }

  Future<void> getAllData() async {
    GroupsOperation groupsOperation = GroupsOperation();
    listGroupInfo = await groupsOperation.getAllGroupsInfo();
    initAllData();
  }

  void initAllData() {
    inputDataListItemGroupModel.add(listGroupInfo);
  }

  Future<void> initControllers() async {
    controllerListItemGroupModel = StreamController();
    inputDataListItemGroupModel = controllerListItemGroupModel.sink;
    outPutDataListItemGroupModel =
        controllerListItemGroupModel.stream.asBroadcastStream();
  }

  Future<void> disposeControllers() async {
    controllerListItemGroupModel.close();
    inputDataListItemGroupModel.close();
  }

  void addNewGroups({required BuildContext context}) {
    Navigator.of(context).pushNamed(RoutesName.kAddNewGroupScreen,
        arguments: ConstValue.kAddNewGroup);
  }

// Stream<List<ItemStageModel>> outPutDataListItemStageModel;
}
