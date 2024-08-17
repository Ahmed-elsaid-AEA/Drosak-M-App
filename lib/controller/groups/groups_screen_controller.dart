import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/routes_mananger.dart';
import 'package:flutter/material.dart';

class GroupsScreenController {
  void addNewGroups({required BuildContext context}) {
    Navigator.of(context).pushNamed(RoutesName.kAddNewGroupScreen,
        arguments: ConstValue.kAddNewGroup);
  }
// Stream<List<ItemStageModel>> outPutDataListItemStageModel;
}
