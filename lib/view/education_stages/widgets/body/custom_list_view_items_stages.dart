import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_item_stage.dart';

class CustomListViewItemsStages extends StatelessWidget {
  const CustomListViewItemsStages(
      {super.key,
      required this.outPutDataListItemStageModel,
      required this.deleteFun,
      required this.editFun,
      required this.onRefresh});

  final Stream<List<ItemStageModel>> outPutDataListItemStageModel;

  final void Function(ItemStageModel itemStageModel) deleteFun;
  final Future<void> Function() onRefresh;
  final void Function(ItemStageModel itemStageModel) editFun;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<ItemStageModel>>(
          stream: outPutDataListItemStageModel,
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CupertinoActivityIndicator(
                    color: ColorManager.kPrimaryColor,
                  ))
                : RefreshIndicator(
                    onRefresh: () async {
                      onRefresh();
                    },
                    child: ListView.separated(
                        itemBuilder: (context, index) =>
                            index == snapshot.data!.length
                                ? VerticalSpace(HeightManager.h24)
                                : CustomItemStage(
                                    deleteFun: deleteFun,
                                    editFun: editFun,
                                    itemStageModel: snapshot.data![index],
                                  ),
                        separatorBuilder: (context, index) =>
                            VerticalSpace(HeightManager.h24),
                        itemCount: snapshot.data!.length + 1),
                  );
          }),
    );
  }
}
