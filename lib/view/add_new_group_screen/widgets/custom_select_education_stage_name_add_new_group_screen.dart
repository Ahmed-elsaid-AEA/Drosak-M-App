import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:flutter/material.dart';

class CustomSelectEducationStageNameAddNewGroupScreen extends StatelessWidget {
  const CustomSelectEducationStageNameAddNewGroupScreen(
      {super.key, required this.listItemStageModel, required this.onChanged});

  final List<ItemStageModel> listItemStageModel;
  final Function(ItemStageModel?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Divider(),
        ),
        const Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            ConstValue.kChooseEducationStage,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: FontsName.geDinerOneFont,
              color: ColorManager.kWhiteColor,
            ),
          ),
        ),
        VerticalSpace(HeightManager.h12),
        CustomDropdown<ItemStageModel>.search(
          hintText: ConstValue.kChooseEducationStage,
          items: listItemStageModel,
          noResultFoundText: ConstValue.kNoFoundThisEducationStageName,
          // initialItem: "a",
          onChanged: onChanged,
        ),
        VerticalSpace(HeightManager.h16),
      ],
    );
  }
}
