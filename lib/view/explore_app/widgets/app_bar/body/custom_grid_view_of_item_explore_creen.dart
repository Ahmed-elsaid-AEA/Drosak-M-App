import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/width_manager.dart';
import 'package:drosak_m_app/view/explore_app/screens/explore_app_screen.dart';
import 'package:flutter/material.dart';

import 'custom_item_explore_screen.dart';

class CustomGridViewOfItemExploreScreen extends StatelessWidget {
  const CustomGridViewOfItemExploreScreen({
    super.key,
    this.onTap,
  });

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: WidthManager.w30),
        itemCount: ConstListValues.listExploreScreenModel.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 138 / 108,
            crossAxisCount: 2,
            crossAxisSpacing: 39,
            mainAxisSpacing: 34),
        itemBuilder: (context, index) => InkWell(
          onTap: onTap,
          child: CustomItemExploreScreen(
              number: index + 1,
              exploreScreenModel:
                  ConstListValues.listExploreScreenModel[index]),
        ),
      ),
    );
  }
}
