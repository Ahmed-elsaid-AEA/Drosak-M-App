import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:flutter/material.dart';

class CustomNumberOrderExploreScreen extends StatelessWidget {
  const CustomNumberOrderExploreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      bottom: -10,
      left: -10,
      child: Center(
        child: CircleAvatar(
          backgroundColor: ColorManager.kPrimaryColor,
          radius: 10,
          child: Text(
            "1",
            style: TextStyle(
                color: ColorManager.kWhiteColor,
                fontWeight: FontWeight.w500,
                fontFamily: FontsName.geDinerOneFont),
          ),
        ),
      ),
    );
  }
}
