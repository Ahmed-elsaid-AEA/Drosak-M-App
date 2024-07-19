import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/resources/width_manager.dart';
import 'package:flutter/material.dart';

import '../../../../model/education_stages/item_stage_model.dart';

class CustomAppBarEductionStages extends StatelessWidget {
  const CustomAppBarEductionStages({
    super.key,
    this.onPressedAdd,
    this.onPressedSearch,
    required this.outPutDataListItemStageModel,
  });

  final Stream<List<ItemStageModel>> outPutDataListItemStageModel;
  final VoidCallback? onPressedAdd;
  final VoidCallback? onPressedSearch;

  @override
  Widget build(BuildContext context) {
    return Container(
      // alignment: AlignmentDirectional.ce,
      color: ColorManager.kPrimaryColor,
      height: HeightManager.h75,
      padding: EdgeInsets.only(
        right: WidthManager.w15,
        left: WidthManager.w15,
        top: HeightManager.h24,
      ),
      child: Row(
        children: [
          StreamBuilder<List<ItemStageModel>>(
            stream: outPutDataListItemStageModel,
            builder: (context, snapshot) => Text(
              '${ConstValue.kEducationalStages} ( ${snapshot.data == null ? "0" : snapshot.data!.length.toString()} )',
              style: TextStyle(
                  fontSize: FontsSize.f15,
                  fontFamily: FontsName.geDinerOneFont,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.kWhiteColor),
            ),
          ),
          const Spacer(),
          IconButton(
              onPressed: onPressedAdd,
              icon: const Icon(
                Icons.add_circle_outline,
                size: 30,
                color: ColorManager.kWhiteColor,
              )),
          IconButton(
              onPressed: onPressedSearch,
              icon: const Icon(
                Icons.search,
                size: 30,
                color: ColorManager.kWhiteColor,
              ))
        ],
      ),
    );
  }
}
