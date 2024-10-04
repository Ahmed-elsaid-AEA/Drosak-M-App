import 'dart:async';
import 'package:drosak_m_app/core/database/sqlite/education_stage_operation.dart';
import 'package:drosak_m_app/core/database/sqlite/groups_operation.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/routes_mananger.dart';
import 'package:drosak_m_app/core/widgets/search/custom_search_delegate.dart';
import 'package:drosak_m_app/model/groups/groups_info_model.dart';
import 'package:drosak_m_app/view/education_stages/widgets/search/custom_list_search_education_stage_screen.dart';
import 'package:drosak_m_app/view/groups/widgets/search/custom_list_search_group_screen.dart';
import 'package:flutter/material.dart';

class GroupsScreenController {
  late StreamController<List<GroupInfoModel>> controllerListItemGroupModel;
  late Sink<List<GroupInfoModel>> inputDataListItemGroupModel;
  late Stream<List<GroupInfoModel>> outPutDataListItemGroupModel;
  List<GroupInfoModel> listGroupInfo = [];
  BuildContext context;
  bool isSearchNow = false;

  GroupsScreenController(this.context) {
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
    Navigator.of(context)
        .pushNamed(RoutesName.kAddNewGroupScreen,
            arguments: ConstValue.kAddNewGroup)
        .then((value) => getAllData());
  }

  void onRefresh() {
    listGroupInfo.clear();
    inputDataListItemGroupModel.add(listGroupInfo);
    getAllData();
  }

// Stream<List<ItemStageModel>> outPutDataListItemStageModel;

  void deleteGroupInfo(GroupInfoModel groupInfoModel) async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(ConstValue.kAreYouSureToDeleteItem),
        actions: [
          TextButton(
              onPressed: () async {
                GroupsOperation groupOperation = GroupsOperation();
                bool deleted = await groupOperation.startDelete(groupInfoModel);

                if (deleted) {
                  if (isSearchNow == true) {
                    Navigator.of(context).pop(true);
                  } else {
                    Navigator.of(context).pop(false);
                  }

                  onRefresh();
                }
              },
              child: const Text(ConstValue.kSure)),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(ConstValue.kNo)),
        ],
      ),
    );
    if(confirmDelete==true){
      Navigator.of(context).pop();
    }
  }

  void editGroupInfo(GroupInfoModel groupInfoModel) {
    Navigator.of(context).pushNamed(RoutesName.kAddNewGroupScreen, arguments: {
      ConstValue.kStatus: ConstValue.kEditThisGroup,
      ConstValue.kGroupInfoModel: groupInfoModel
    }).then((value) {
      getAllData();
      if (isSearchNow == true) {
        Navigator.of(context).pop();
        isSearchNow = false;
      }
    });
  }

  void onPressedSearch() {
    isSearchNow = true;

    showSearch(
        context: context,
        delegate: CustomSearchDelegated(
          myBuildResult: (String query) {
            GroupsOperation groupsOperation = GroupsOperation();
            return query == ''
                ? const SizedBox()
                : CustomListSearchGroupScreen(
                    getSearchItemGroups:
                        groupsOperation.getSearchWord(groupName: query),
                    editFun: (groupInfoModel) {
                      editGroupInfo(groupInfoModel);
                    },
                    deleteFun: (groupInfoModel) {
                      deleteGroupInfo(groupInfoModel);
                    },
                  );
          },
        )).then((value) => isSearchNow = false);
  }
}
