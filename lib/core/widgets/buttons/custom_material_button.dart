import 'package:flutter/material.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/padding_manager.dart';
import 'package:drosak_m_app/core/resources/radius_values_manager.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton(
      {super.key, required this.onPressed, required this.text});

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(RadiusValuesManager.br12))),
      padding: EdgeInsets.symmetric(
          vertical: PaddingManager.ph10, horizontal: PaddingManager.pw42),
      onPressed: onPressed,
      color: ColorManager.kPrimaryColor,
      child: Text(text,
          style: TextStyle(
              color: ColorManager.kWhiteColor,
              fontSize: FontsSize.f16,
              fontWeight: FontWeight.bold,
              fontFamily: FontsName.geDinerOneFont)),
    );
  }
}
