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

import '../widgets/body/custom_page_view_on_boarding_screen.dart';
import '../widgets/bottom_nav_bar/custom_nav_bar_on_borading_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBarOnBoardingScreen(
        currentDot: 1,
        dotCount: ConstListValues.listOnBoardingImage.length,
      ),
      body: SafeArea(
        child: CustomPageViewOnBoardingScreen(),
      ),
    );
  }
}
