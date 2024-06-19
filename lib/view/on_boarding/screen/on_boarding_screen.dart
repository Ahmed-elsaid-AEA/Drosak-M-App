import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AssetsValuesManager.kOnBoardingImage5,
                height: 200,
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                ConstValue.kOnBoardingText1,
                style: TextStyle(
                    fontFamily: 'AA-GALAXY',
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
