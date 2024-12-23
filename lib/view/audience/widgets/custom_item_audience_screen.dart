import 'dart:io';

import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/resources/margin_manager.dart';
import 'package:drosak_m_app/core/resources/padding_manager.dart';
import 'package:drosak_m_app/core/resources/radius_values_manager.dart';
import 'package:drosak_m_app/core/resources/width_manager.dart';
import 'package:drosak_m_app/core/widgets/space/horizontal_space.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:drosak_m_app/model/groups/groups_info_model.dart';
import 'package:drosak_m_app/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomItemAudienceScreen extends StatelessWidget {
  const CustomItemAudienceScreen({
    super.key,
    required this.studentModel,
    required this.deleteFun,
    required this.editFun,
  });

  final StudentModel studentModel;
  final void Function(StudentModel itemStageModel) deleteFun;
  final void Function(StudentModel itemStageModel) editFun;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        print("a");
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 2,
            top: -20,
            child: Center(
              child: CircleAvatar(
                backgroundColor: ColorManager.kPrimaryColor,
                child: Text(
                  studentModel.id.toString(),
                  style: TextStyle(
                    color: ColorManager.kWhiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: FontsSize.f15,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: ColorManager.kPrimaryColor,
                  blurRadius: 5,
                  blurStyle: BlurStyle.outer,
                  offset: Offset(0, 0),
                  spreadRadius: 1,
                )
              ],
              borderRadius:
                  BorderRadius.all(Radius.circular(RadiusValuesManager.br18)),
              border: Border.all(color: ColorManager.kPrimaryColor),
            ),
            margin: EdgeInsets.symmetric(horizontal: MarginManager.mw16),
            child: Padding(
              padding: EdgeInsets.only(
                right: PaddingManager.pw22,
                left: PaddingManager.pw10,
                top: PaddingManager.ph16,
                bottom: PaddingManager.ph6,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                        Radius.circular(RadiusValuesManager.br50)),
                    child: Image.file(
                      errorBuilder: (context, error, stackTrace) =>
                          SvgPicture.asset(
                        AssetsValuesManager.assetsImagesPlaceholderSvg,
                        width: WidthManager.w50,
                      ),
                      File(
                        studentModel.image,
                      ),
                      height: HeightManager.h50,
                      width: WidthManager.w50,
                    ),
                  ),
                  VerticalSpace(HeightManager.h9),
                  Text(
                    studentModel.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: FontsSize.f12,
                      color: ColorManager.kWhiteColor,
                      fontFamily: FontsName.geDinerOneFont,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
