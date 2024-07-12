import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/padding_manager.dart';
import 'package:drosak_m_app/core/resources/radius_values_manager.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.hintText,
      required this.controller,
      this.onSubmitted,
      this.maxLines = 1,
      this.validator});

  final String? hintText;
  final TextEditingController controller;
  final ValueChanged<String>? onSubmitted;
  final int? maxLines;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: TextAlign.right,
      controller: controller,
      validator: validator,
      onFieldSubmitted: onSubmitted,
      maxLines: maxLines,
      decoration: InputDecoration(
          hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorManager.kBlackColor,
              fontFamily: FontsName.geDinerOneFont,
              fontSize: FontsSize.f14),
          contentPadding: EdgeInsets.symmetric(horizontal: PaddingManager.pw14),
          hintText: hintText,
          fillColor: ColorManager.kWhiteColor,
          filled: true,
          border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(RadiusValuesManager.br12)))),
    );
  }
}
