import 'package:drosak_m_app/controller/explore_app/explore_app_controller.dart';
import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/resources/margin_manager.dart';
import 'package:drosak_m_app/core/resources/radius_values_manager.dart';
import 'package:drosak_m_app/core/resources/routes_mananger.dart';
import 'package:drosak_m_app/core/resources/width_manager.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/app_bar/body/body_explore_screen.dart';
import '../widgets/app_bar/custom_app_bar_explore_screen.dart';

class ExploreAppScreen extends StatefulWidget {
  const ExploreAppScreen({super.key});

  @override
  State<ExploreAppScreen> createState() => _ExploreAppScreenState();
}

class _ExploreAppScreenState extends State<ExploreAppScreen> {
  late ExploreAppController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = ExploreAppController();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: BodyExploreScreen(
          onTap: (index) {
            controller.goToMainScreen(value: index, context: context);
          },
        ),
        backgroundColor: ColorManager.kBlackColor,
        appBar: CustomAppBarExploreScreen(),
      ),
    );
  }
}
