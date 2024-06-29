import 'package:drosak_m_app/controller/on_boarding/on_borading_controller.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:flutter/material.dart';

import '../widgets/body/custom_page_view_on_boarding_screen.dart';
import '../widgets/bottom_nav_bar/custom_nav_bar_on_borading_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late OnBoardingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = OnBoardingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.kWhiteColor,
      bottomNavigationBar: CustomBottomNavBarOnBoardingScreen(
        onPressedSkip: () {
          _controller.skip(context);
        },
        onPressedNext: () {
          _controller.goNext();
        },
        dotCount: ConstListValues.listOnBoardingModel.length,
        outPutDotIndicator: _controller.outPutDotIndicator,
      ),
      body: SafeArea(
        child: CustomPageViewOnBoardingScreen(
          controller: _controller.pageControllerOnBoardingScreen,
        ),
      ),
    );
  }
}
