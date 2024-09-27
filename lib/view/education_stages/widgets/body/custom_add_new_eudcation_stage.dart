import 'dart:io';

import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/resources/padding_manager.dart';
import 'package:drosak_m_app/core/resources/radius_values_manager.dart';
import 'package:drosak_m_app/core/resources/width_manager.dart';
import 'package:drosak_m_app/core/widgets/buttons/custom_material_button.dart';
import 'package:drosak_m_app/core/widgets/input_field/custom_text_form_field.dart';
import 'package:drosak_m_app/core/widgets/space/horizontal_space.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAddNewEducationStage extends StatelessWidget {
  const CustomAddNewEducationStage({
    super.key,
    required this.controllerNameEducationStage,
    required this.controllerDescEducationStage,
    required this.onPressedAdd,
    required this.onPressedPickImage,
    required this.onPressedDeleteImage,
    required this.outPathImage,
    required this.formKey,
    this.edit = false,
  });

  final VoidCallback onPressedAdd;
  final VoidCallback onPressedPickImage;
  final VoidCallback onPressedDeleteImage;
  final TextEditingController controllerNameEducationStage;
  final TextEditingController controllerDescEducationStage;
  final Stream<String?> outPathImage;
  final GlobalKey<FormState> formKey;
  final bool edit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: PaddingManager.pw12, vertical: PaddingManager.ph22),
            decoration: BoxDecoration(
                color: ColorManager.kBlackLight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(RadiusValuesManager.br12),
                  topRight: Radius.circular(RadiusValuesManager.br12),
                )),
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Form(
                        key: formKey,
                        child: CustomTextFormField(
                          validator: (value) {
                            if (value == null || value == '') {
                              return ConstValue.kCantEmpty;
                            } else {
                              return null;
                            }
                          },
                          controller: controllerNameEducationStage,
                          hintText: ConstValue.kNameEducationalStages,
                        ),
                      ),
                    ),
                    HorizontalSpace(WidthManager.w6),
                    IconButton.filled(
                        onPressed: onPressedPickImage,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.kPrimaryColor),
                        icon: SvgPicture.asset(
                            AssetsValuesManager.kPlaceholderSvg)),
                  ],
                ),
                VerticalSpace(HeightManager.h12),
                CustomTextFormField(
                  maxLines: 3,
                  controller: controllerDescEducationStage,
                  hintText: ConstValue.kDescEducationalStage,
                ),
                VerticalSpace(HeightManager.h24),
                StreamBuilder(
                    stream: outPathImage,
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const Center(
                              child: CupertinoActivityIndicator(),
                            )
                          : snapshot.data != null && snapshot.data!.trim() != ""
                              ? Column(
                                  children: [
                                    Stack(
                                      children: [
                                        Image.file(
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Text(
                                              "not found",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            );
                                          },
                                          File(snapshot.data!),
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                        IconButton.filled(
                                          onPressed: onPressedDeleteImage,
                                          icon: const Icon(Icons.delete),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red),
                                        ),
                                      ],
                                    ),
                                    VerticalSpace(HeightManager.h24),
                                  ],
                                )
                              : const SizedBox();
                    }),
                CustomMaterialButton(
                    onPressed: onPressedAdd,
                    text: edit == true ? ConstValue.kEdit : ConstValue.kAdd)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
