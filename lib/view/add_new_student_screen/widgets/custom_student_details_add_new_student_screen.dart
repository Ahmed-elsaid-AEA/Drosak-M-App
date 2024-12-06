import 'dart:io';

import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/resources/width_manager.dart';
import 'package:drosak_m_app/core/widgets/input_field/custom_text_form_field.dart';
import 'package:drosak_m_app/core/widgets/space/horizontal_space.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomGroupDetailsAddNewStudentScreen extends StatelessWidget {
  const CustomGroupDetailsAddNewStudentScreen(
      {super.key,
      required this.formStateStudentDetails,
      required this.controllerStudentName,
      required this.controllerGroupDesc,
      required this.outPathImage,
      required this.onPressedDeleteImage});

  final GlobalKey<FormState> formStateStudentDetails;
  final TextEditingController controllerStudentName;
  final TextEditingController controllerGroupDesc;
  final Stream<String?> outPathImage;
  final VoidCallback onPressedDeleteImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          ConstValue.kDetailsStudent,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: FontsName.geDinerOneFont,
            color: ColorManager.kWhiteColor,
          ),
        ),
        VerticalSpace(HeightManager.h12),
        Row(
          children: [
            Expanded(
              child: Form(
                key: formStateStudentDetails,
                child: CustomTextFormField(
                  validator: (value) {
                    if (value == null || value == '') {
                      return ConstValue.kCantEmpty;
                    } else {
                      return null;
                    }
                  },
                  controller: controllerStudentName,
                  hintText: ConstValue.kNameStudent,
                ),
              ),
            ),
            HorizontalSpace(WidthManager.w6),
            IconButton.filled(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.kPrimaryColor),
                icon: SvgPicture.asset(AssetsValuesManager.kPlaceholderSvg)),
          ],
        ),
        VerticalSpace(HeightManager.h12),
        CustomTextFormField(
          maxLines: 3,
          controller: controllerGroupDesc,
          hintText: ConstValue.kNote,
        ),
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
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Text(
                                      "not found",
                                      style: TextStyle(color: Colors.white),
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
      ],
    );
  }
}
