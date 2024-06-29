import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/resources/margin_manager.dart';
import 'package:drosak_m_app/core/resources/radius_values_manager.dart';
import 'package:drosak_m_app/core/resources/width_manager.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/app_bar/custom_app_bar_explore_screen.dart';

class ExploreAppScreen extends StatelessWidget {
  const ExploreAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: BodyExploreScreen(),
        backgroundColor: ColorManager.kBlackColor,
        appBar: CustomAppBarExploreScreen(),
      ),
    );
  }
}

class BodyExploreScreen extends StatelessWidget {
  const BodyExploreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerticalSpace(HeightManager.h24),
        CustomGridViewOfItemExploreScreen(),
      ],
    );
  }
}

class CustomGridViewOfItemExploreScreen extends StatelessWidget {
  const CustomGridViewOfItemExploreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: WidthManager.w30),
        itemCount: 5,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 138 / 108,
            crossAxisCount: 2,
            crossAxisSpacing: 39,
            mainAxisSpacing: 34),
        itemBuilder: (context, index) => CustomItemExploreScreen(),
      ),
    );
  }
}

class CustomItemExploreScreen extends StatelessWidget {
  const CustomItemExploreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CustomShadowContainerExploreScreen(),
        CustomContainerOfNameAndImageExploreScreen(),
        Positioned(
          bottom: -16,
          left: -16,
          child: Center(
            child: CircleAvatar(
              backgroundColor: ColorManager.kBlackColor,
              radius: 16,
            ),
          ),
        ),
        CustomNumberOrderExploreScreen(),
      ],
    );
  }
}

class CustomShadowContainerExploreScreen extends StatelessWidget {
  const CustomShadowContainerExploreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -16,
      left: -16,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
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
      ),
    );
  }
}

class CustomNumberOrderExploreScreen extends StatelessWidget {
  const CustomNumberOrderExploreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -10,
      left: -10,
      child: Center(
        child: CircleAvatar(
          child: Text(
            "1",
            style: TextStyle(
                color: ColorManager.kWhiteColor,
                fontWeight: FontWeight.w500,
                fontFamily: FontsName.geDinerOneFont),
          ),
          backgroundColor: ColorManager.kPrimaryColor,
          radius: 10,
        ),
      ),
    );
  }
}

class CustomContainerOfNameAndImageExploreScreen extends StatelessWidget {
  const CustomContainerOfNameAndImageExploreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: WidthManager.w7,
                vertical: HeightManager.h3),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(RadiusValuesManager.br12)),
              color: ColorManager.kPrimaryColor,
            ),
            child: Text("المراحل التعليمية",
                style: TextStyle(
                    color: ColorManager.kWhiteColor,
                    fontFamily: FontsName.geDinerOneFont,
                    fontWeight: FontWeight.w500,
                    fontSize: FontsSize.f15)),
            margin: EdgeInsets.symmetric(
                vertical: MarginManager.mh5,
                horizontal: MarginManager.mw5),
          ),
          SvgPicture.asset(
            AssetsValuesManager.kOnBoardingImage1,
            height: HeightManager.h63,
          ),
        ],
      ),
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
    );
  }
}
