import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/model/on_boarding/on_boarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomItemOnBoardingScreen extends StatelessWidget {
  const CustomItemOnBoardingScreen({
    super.key,
    required this.onBoardingModel,
  });

  final OnBoardingModel onBoardingModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            onBoardingModel.image,
            height: 200,
          ),
          SizedBox(
            height: 50,
          ),
          Text(
          onBoardingModel.text,
            textAlign: TextAlign.center,
            style: TextStyle(

                fontFamily: 'AA-GALAXY',
                fontWeight: FontWeight.bold,
                fontSize: 20),
          )
        ],
      ),
    );
  }
}
