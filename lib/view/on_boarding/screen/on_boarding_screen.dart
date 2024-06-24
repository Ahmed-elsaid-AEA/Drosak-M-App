import 'package:dots_indicator/dots_indicator.dart';
import 'package:drosak_m_app/controller/on_boarding/on_borading_controller.dart';
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

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
 late  OnBoardingController _controller ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller=OnBoardingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavBarOnBoardingScreen(
        onPressed: () {
          _controller.goNext();
        },
        dotCount: ConstListValues.listOnBoardingImage.length, outPutDotIndicator: _controller.outPutDotIndicator,
      ),
      body: SafeArea(
        child: CustomPageViewOnBoardingScreen(controller: _controller.pageControllerOnBoardingScreen,),
      ),
    );
  }
}
