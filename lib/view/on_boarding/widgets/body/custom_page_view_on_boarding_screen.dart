import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/view/on_boarding/widgets/body/custom_item_on_boarding_screen.dart';
import 'package:flutter/material.dart';

class CustomPageViewOnBoardingScreen extends StatelessWidget {
  const CustomPageViewOnBoardingScreen({
    super.key, required this.controller,
  });
final PageController controller;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: PageView.builder(
        controller: controller,
        itemCount: ConstListValues.listOnBoardingModel.length,
        itemBuilder: (context, index) => CustomItemOnBoardingScreen(
          onBoardingModel: ConstListValues.listOnBoardingModel[index],
        ),
      ),
    );
  }
}
