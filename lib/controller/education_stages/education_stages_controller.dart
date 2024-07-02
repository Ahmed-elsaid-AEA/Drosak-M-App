import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/padding_manager.dart';
import 'package:drosak_m_app/core/resources/radius_values_manager.dart';
import 'package:drosak_m_app/core/resources/width_manager.dart';
import 'package:drosak_m_app/core/widgets/space/horizontal_space.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EducationStagesController {
  List<ItemStageModel> listItemStageModel = [];

  void openBottomSheet({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(
            horizontal: PaddingManager.pw12, vertical: PaddingManager.ph22),
        decoration: BoxDecoration(
            color: ColorManager.kBlackLight,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(RadiusValuesManager.br12),
              topRight: Radius.circular(RadiusValuesManager.br12),
            )),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(),
                        hintText: "إسم المرحلة التعليمية",
                        fillColor: ColorManager.kWhiteColor,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(RadiusValuesManager.br12)))),
                  ),
                ),
                HorizontalSpace(WidthManager.w6),
                IconButton.filled(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManager.kPrimaryColor),
                    icon: SvgPicture.asset(AssetsValuesManager.kPlaceholderSvg))
              ],
            )
          ],
        ),
      ),
    );
  }
}
