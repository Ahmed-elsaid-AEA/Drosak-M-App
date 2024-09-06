import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/resources/width_manager.dart';
import 'package:drosak_m_app/core/widgets/space/horizontal_space.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:flutter/material.dart';

class CustomSelectEducationStageNameAddNewGroupScreen extends StatelessWidget {
  const CustomSelectEducationStageNameAddNewGroupScreen(
      {super.key,
      required this.outPutDataListItemStageModel,
      required this.onChanged});

  final Function(ItemStageModel?)? onChanged;
  final Stream<List<ItemStageModel>> outPutDataListItemStageModel;

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
        StreamBuilder(
          stream: outPutDataListItemStageModel,
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : CustomDropdown<ItemStageModel>.search(
                  hintText: ConstValue.kChooseEducationStage,
                  items: snapshot.data,
                  noResultFoundText: ConstValue.kNoFoundThisEducationStageName,
                  // initialItem: "a",
                  listItemBuilder: (context, item, isSelected, onItemSelect) =>
                      ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      item.stageName,
                      style: TextStyle(
                          color: ColorManager.kBlackColor,
                          fontSize: FontsSize.f14),
                    ),
                    subtitle: item.desc.isEmpty ? null : Text(item.desc),
                    leading: CircleAvatar(
                        radius: 10,
                        backgroundColor: ColorManager.kPrimaryColor,
                        child: Text(
                          item.id.toString(),
                          style: TextStyle(
                              color: ColorManager.kWhiteColor,
                              fontSize: FontsSize.f9),
                        )),
                  ),
                  onChanged: onChanged,
                  itemsListPadding: EdgeInsets.zero,
                  headerBuilder: (context, item, enabled) => Row(
                    children: [
                      CircleAvatar(
                          radius: 10,
                          backgroundColor: ColorManager.kPrimaryColor,
                          child: Text(
                            item.id.toString(),
                            style: TextStyle(
                                color: ColorManager.kWhiteColor,
                                fontSize: FontsSize.f9),
                          )),
                      HorizontalSpace(WidthManager.w15),
                      Expanded(
                          child: Text(
                        item.stageName,
                        style: TextStyle(
                            color: ColorManager.kBlackColor,
                            fontSize: FontsSize.f14),
                        maxLines: 1,
                      )),
                    ],
                  ),
                ),
        ),
        VerticalSpace(HeightManager.h16),
      ],
    );
  }
}
