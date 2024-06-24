import 'package:dots_indicator/dots_indicator.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/resources/padding_manager.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBarOnBoardingScreen extends StatelessWidget {
  const CustomBottomNavBarOnBoardingScreen({
    super.key,
    required this.dotCount,
    this.onPressedNext,
    required this.outPutDotIndicator, this.onPressedSkip,
  });

  final int dotCount;
  final VoidCallback? onPressedNext;
  final VoidCallback? onPressedSkip;
  final Stream<int> outPutDotIndicator;

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
          InkWell(
              onTap: onPressedSkip,
              child: const CustomText(text: ConstValue.kSkip)),
          Directionality(
            textDirection: TextDirection.rtl,
            child: StreamBuilder<int>(
              stream: outPutDotIndicator,
              builder: (context, snapshot) => DotsIndicator(
                dotsCount: dotCount,
                position: snapshot.data == null ? 0 : snapshot.data!,
                decorator: DotsDecorator(
                  activeColor: ColorManager.kWhiteColor, // Inactive color
                  color: ColorManager.kWhiteColor.withOpacity(.3),
                ),
              ),
            ),
          ),
          InkWell(
              onTap: onPressedNext,
              child: const CustomText(text: ConstValue.kNext)),
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
          fontFamily: FontsName.geDinerOneFont,
          color: ColorManager.kWhiteColor,
          fontWeight: FontWeight.w500,
          fontSize: FontsSize.f15),
    );
  }
}
