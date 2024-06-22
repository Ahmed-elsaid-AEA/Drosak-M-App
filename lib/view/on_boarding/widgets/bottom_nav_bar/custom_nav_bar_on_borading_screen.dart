import 'package:dots_indicator/dots_indicator.dart';
import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/resources/padding_manager.dart';
import 'package:drosak_m_app/view/on_boarding/widgets/body/custom_item_on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBarOnBoardingScreen extends StatelessWidget {
  const CustomBottomNavBarOnBoardingScreen({
    super.key,
    required this.dotCount,
    required this.currentDot,
  });

  final int dotCount;
  final int currentDot;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: PaddingManager.pw12, vertical: PaddingManager.ph10),
      color: ColorManager.kPrimaryColor,
      height: HeightManager.h39,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CustomText(text: ConstValue.kSkip),
          Directionality(
            textDirection: TextDirection.rtl,
            child: DotsIndicator(
              dotsCount: dotCount,
              position: currentDot,
              decorator: DotsDecorator(
                activeColor: ColorManager.kWhiteColor, // Inactive color
                color:ColorManager.kWhiteColor.withOpacity(.3),
              ),
            ),
          ),
          const CustomText(text: ConstValue.kNext),
        ],
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: FontsSize.geDinerOneFont,
          color: ColorManager.kWhiteColor,
          fontWeight: FontWeight.w500,
          fontSize: FontsName.f15),
    );
  }
}
