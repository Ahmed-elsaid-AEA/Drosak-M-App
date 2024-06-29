import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/resources/width_manager.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:flutter/material.dart';

import '../widgets/app_bar/custom_app_bar_explore_screen.dart';

class ExploreAppScreen extends StatelessWidget {
  const ExploreAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            VerticalSpace(HeightManager.h24),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: WidthManager.w30),
                itemCount: 5,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 138 / 108,
                    crossAxisCount: 2,
                    crossAxisSpacing: 39,
                    mainAxisSpacing: 34),
                itemBuilder: (context, index) => Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      bottom: -16,
                      left: -16,
                      child: Container(
                        width: 32,
                        height: 32,
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
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: ColorManager.kBlackColor,
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
                    Positioned(
                      bottom: -10,
                      left: -10,
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: ColorManager.kPrimaryColor,
                          radius: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        backgroundColor: ColorManager.kBlackColor,
        appBar: CustomAppBarExploreScreen(),
      ),
    );
  }
}
