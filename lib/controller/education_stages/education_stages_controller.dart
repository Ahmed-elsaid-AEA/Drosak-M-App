import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/resources/padding_manager.dart';
import 'package:drosak_m_app/core/resources/radius_values_manager.dart';
import 'package:drosak_m_app/core/resources/width_manager.dart';
import 'package:drosak_m_app/core/widgets/input_field/custom_text_form_field.dart';
import 'package:drosak_m_app/core/widgets/space/horizontal_space.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EducationStagesController {
  List<ItemStageModel> listItemStageModel = [];

  void openBottomSheet({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
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
                    child: CustomTextFormField(),
                  ),
                  HorizontalSpace(WidthManager.w6),
                  IconButton.filled(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.kPrimaryColor),
                      icon:
                          SvgPicture.asset(AssetsValuesManager.kPlaceholderSvg))
                ],
              ),
              VerticalSpace(HeightManager.h40),

            ],
          ),
        ),
      ),
    );
  }
}

