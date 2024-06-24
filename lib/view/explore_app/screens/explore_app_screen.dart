import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:flutter/material.dart';

import '../widgets/app_bar/custom_app_bar_explore_screen.dart';

class ExploreAppScreen extends StatelessWidget {
  const ExploreAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 30),
          itemCount: 5,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 39, mainAxisSpacing: 34),
          itemBuilder: (context, index) => Container(
            
            decoration: BoxDecoration(
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
            width: 100,
            height: 100,
          ),
        ),
        backgroundColor: ColorManager.kBlackColor,
        appBar: CustomAppBarExploreScreen(),
      ),
    );
  }
}
