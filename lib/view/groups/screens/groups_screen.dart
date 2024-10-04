import 'package:drosak_m_app/controller/groups/groups_screen_controller.dart';
import 'package:drosak_m_app/core/database/sqlite/groups_operation.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/widgets/app_bar/custom_app_bar_title_add_search.dart';
import 'package:drosak_m_app/view/groups/widgets/custom_list_view_item_groups.dart';
import 'package:flutter/material.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  late GroupsScreenController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = GroupsScreenController(context);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBarTitleAddSearch(
              title: ConstValue.kGroups,
              onPressedSearch: () {
                _controller.onPressedSearch( );
              },
              onPressedAdd: () {
                _controller.addNewGroups(context: context);
              },
              streamCount: _controller.outPutDataListItemGroupModel,
            ),
            CustomListViewItemsGroups(
              outPutDataListItemGroupModel:
                  _controller.outPutDataListItemGroupModel,
              editFun:_controller.editGroupInfo,
              deleteFun:_controller. deleteGroupInfo,
              onRefresh: () {
                _controller.onRefresh();
              },
            ),
          ],
        ),
      ),
    );
  }
}
