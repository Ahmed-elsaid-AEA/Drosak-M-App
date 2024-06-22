import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/view/on_boarding/widgets/body/custom_item_on_boarding_screen.dart';
import 'package:flutter/material.dart';

class CustomPageViewOnBoardingScreen extends StatelessWidget {
  const CustomPageViewOnBoardingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: ConstListValues.listOnBoardingImage.length,
      itemBuilder: (context, index) => CustomItemOnBoardingScreen(
        onBoardingModel: ConstListValues.listOnBoardingImage[index],
      ),
    );
  }
}
