import 'package:drosak_m_app/view/explore_app/screens/explore_app_screen.dart';
import 'package:drosak_m_app/view/explore_app/widgets/app_bar/body/custom_container_of_name_and_image_explore_screen.dart';
import 'package:drosak_m_app/view/explore_app/widgets/app_bar/body/custom_shadow_container_explore_screeen.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/colors_manager.dart';
import 'custom_number_order_explore_screen.dart';

class CustomItemExploreScreen extends StatelessWidget {
  const CustomItemExploreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Stack(
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
