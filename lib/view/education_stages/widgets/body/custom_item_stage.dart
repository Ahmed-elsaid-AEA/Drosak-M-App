import 'dart:io';

import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/resources/margin_manager.dart';
import 'package:drosak_m_app/core/resources/padding_manager.dart';
import 'package:drosak_m_app/core/resources/radius_values_manager.dart';
import 'package:drosak_m_app/core/resources/width_manager.dart';
import 'package:drosak_m_app/core/widgets/space/horizontal_space.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:drosak_m_app/generated/assets.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:flutter/material.dart';

class CustomItemStage extends StatelessWidget {
  const CustomItemStage({
    super.key,
    required this.itemStageModel,
  });

  final ItemStageModel itemStageModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 2,
          top: -20,
          child: Center(
            child: CircleAvatar(
              backgroundColor: ColorManager.kPrimaryColor,
              child: Text(
                itemStageModel.id.toString(),
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
              top: PaddingManager.ph6,
              bottom: PaddingManager.ph6,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        itemStageModel.stageName,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: FontsSize.f16,
                            color: ColorManager.kWhiteColor,
                            fontFamily: FontsName.geDinerOneFont),
                      ),
                      VerticalSpace(HeightManager.h5),
                      Row(
                        children: [
                          HorizontalSpace(WidthManager.w3),
                          Expanded(
                            child: Text(
                              itemStageModel.desc,
                              style: TextStyle(
                                  color:
                                      ColorManager.kWhiteColor.withOpacity(.6),
                                  fontFamily: FontsName.geDinerOneFont,
                                  fontSize: FontsSize.f10),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                HorizontalSpace(WidthManager.w7),
                ClipRRect(
                  child: Image.file(
                    errorBuilder: (context, error, stackTrace) => true
                        ? Text("not found",style: TextStyle(color: ColorManager.kWhiteColor),)
                        : Image.asset(Assets.imagesTest),
                    File(itemStageModel.image),
                    height: HeightManager.h64,
                    width: WidthManager.w64,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
