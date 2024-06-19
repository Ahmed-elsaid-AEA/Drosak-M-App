import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorManager.kBlackColor,

        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Image.asset(AssetsValuesManager.kSplashBorderImage),
              Align(child: Image.asset(AssetsValuesManager.kLogoImage)),
              Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Image.asset(AssetsValuesManager.kSplashBorderImageBottom)),

            ],
          ),

        ),
        );
  }
}
