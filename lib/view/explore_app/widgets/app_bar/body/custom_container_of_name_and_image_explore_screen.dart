import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/resources/margin_manager.dart';
import 'package:drosak_m_app/core/resources/radius_values_manager.dart';
import 'package:drosak_m_app/core/resources/width_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomContainerOfNameAndImageExploreScreen extends StatelessWidget {
  const CustomContainerOfNameAndImageExploreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorManager.kBlackColor,
          borderRadius: BorderRadius.all(Radius.circular(18)),
          boxShadow: [
            BoxShadow(
              color: ColorManager.kPrimaryColor,
              blurRadius: 15,
              blurStyle: BlurStyle.outer,
              offset: Offset(0, 0),
              spreadRadius: 1,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: WidthManager.w7, vertical: HeightManager.h3),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(RadiusValuesManager.br12)),
              color: ColorManager.kPrimaryColor,
            ),
            margin: EdgeInsets.symmetric(
                vertical: MarginManager.mh5, horizontal: MarginManager.mw5),
            child: Text("المراحل التعليمية",
                style: TextStyle(
                    color: ColorManager.kWhiteColor,
                    fontFamily: FontsName.geDinerOneFont,
                    fontWeight: FontWeight.w500,
                    fontSize: FontsSize.f15)),
          ),
          SvgPicture.asset(
            AssetsValuesManager.kOnBoardingImage1,
            height: HeightManager.h63,
          ),
        ],
      ),
    );
  }
}
