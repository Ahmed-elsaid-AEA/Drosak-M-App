import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:drosak_m_app/view/explore_app/screens/explore_app_screen.dart';
import 'package:flutter/material.dart';

import 'custom_grid_view_of_item_explore_creen.dart';

class BodyExploreScreen extends StatelessWidget {
  const BodyExploreScreen({
    super.key,
    required this.onTap,
  });

  final void Function(int index) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerticalSpace(HeightManager.h24),
        CustomGridViewOfItemExploreScreen(onTap: onTap),
      ],
    );
  }
}
