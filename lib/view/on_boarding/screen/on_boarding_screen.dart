import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/view/on_boarding/widgets/body/custom_item_on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/body/custom_page_view_on_boarding_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: ColorManager.kPrimaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ConstValue.kSkip,
              style: TextStyle(
                  fontFamily: 'ge_diner_one',
                  color: ColorManager.kWhiteColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),Text(
              ConstValue.kNext,
              style: TextStyle(
                  fontFamily: 'ge_diner_one',
                  color: ColorManager.kWhiteColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 15),
            ),

          ],
        ),
        height: HeightManager.h39,
      ),
      body: const SafeArea(
        child: CustomPageViewOnBoardingScreen(),
      ),
    );
  }
}
