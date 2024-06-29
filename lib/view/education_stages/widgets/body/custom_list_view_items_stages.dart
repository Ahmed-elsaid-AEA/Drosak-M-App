import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:flutter/material.dart';

import 'custom_item_stage.dart';

class CustomListViewItemsStages extends StatelessWidget {
  final List<ItemStageModel> listItemStageModel;

  const CustomListViewItemsStages(
      {super.key, required this.listItemStageModel});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) => CustomItemStage(
                itemStageModel: listItemStageModel[index],
              ),
          separatorBuilder: (context, index) =>
              VerticalSpace(HeightManager.h24),
          itemCount: listItemStageModel.length),
    );
  }
}
