import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:drosak_m_app/model/groups/groups_info_model.dart';
import 'package:drosak_m_app/view/groups/widgets/custom_item_group.dart';
import 'package:flutter/cupertino.dart';

class CustomListSearchGroupScreen extends StatelessWidget {
  const CustomListSearchGroupScreen(
      {super.key,
      required this.getSearchItemGroups,
      required this.deleteFun,
      required this.editFun});

  final Future<List<GroupInfoModel>> getSearchItemGroups;
  final void Function(GroupInfoModel groupInfoModel) deleteFun;
  final void Function(GroupInfoModel groupInfoModel) editFun;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<GroupInfoModel>>(
        future: getSearchItemGroups,
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CupertinoActivityIndicator(
                  color: ColorManager.kPrimaryColor,
                ))
              : Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      VerticalSpace(HeightManager.h24),
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) =>
                                index == snapshot.data!.length
                                    ? VerticalSpace(HeightManager.h24)
                                    : CustomItemGroup(
                                        groupInfoModel: snapshot.data![index],
                                        deleteFun: deleteFun,
                                        editFun: editFun,
                                      ),
                            separatorBuilder: (context, index) =>
                                VerticalSpace(HeightManager.h24),
                            itemCount: snapshot.data!.length + 1),
                      ),
                    ],
                  ),
                );
        });
  }
}
