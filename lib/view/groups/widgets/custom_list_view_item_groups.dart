import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:drosak_m_app/model/groups/groups_info_model.dart';
import 'package:drosak_m_app/view/education_stages/widgets/body/custom_item_stage.dart';
import 'package:drosak_m_app/view/groups/widgets/custom_item_group.dart';
import 'package:flutter/cupertino.dart';

class CustomListViewItemsGroups extends StatelessWidget {
  const CustomListViewItemsGroups({super.key,
    required this.outPutDataListItemGroupModel,
    required this.deleteFun,
    required this.editFun});

  final Stream<List<GroupInfoModel>> outPutDataListItemGroupModel;

  final void Function(ItemStageModel itemStageModel) deleteFun;
  final void Function(ItemStageModel itemStageModel) editFun;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: outPutDataListItemGroupModel,
      builder: (context, snapshot) =>
          Expanded(
            child: snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                child: CupertinoActivityIndicator(
                  color: ColorManager.kPrimaryColor,
                ))
                : ListView.separated(
                itemBuilder: (context, index) =>
                index == snapshot.data!.length
                    ? VerticalSpace(HeightManager.h24)
                    :
                CustomItemGroup(
                  groupInfoModel: snapshot.data![index],
                  deleteFun: deleteFun,
                  editFun: editFun,
                ),
                separatorBuilder: (context, index) =>
                    VerticalSpace(HeightManager.h24),
                itemCount: snapshot.data!.length+1),
          ),
    );
  }
}
