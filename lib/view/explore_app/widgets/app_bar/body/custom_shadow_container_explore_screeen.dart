
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';

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
        decoration: const BoxDecoration(
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
