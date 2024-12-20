import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/resources/padding_manager.dart';
import 'package:drosak_m_app/core/resources/radius_values_manager.dart';
import 'package:drosak_m_app/core/widgets/input_field/custom_text_form_field.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomGroupDetailsAddNewStudentScreen extends StatelessWidget {
  const CustomGroupDetailsAddNewStudentScreen(
      {super.key,
      required this.formStateStudentDetails,
      required this.controllerStudentName,
      required this.controllerGroupDesc,
      required this.outPathImage,
      required this.onPressedDeleteImage,
      required this.onPressedPickImage});

  final GlobalKey<FormState> formStateStudentDetails;
  final TextEditingController controllerStudentName;
  final TextEditingController controllerGroupDesc;
  final Stream<String?> outPathImage;
  final VoidCallback onPressedDeleteImage;
  final VoidCallback onPressedPickImage;

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
          ],
        ),
        VerticalSpace(HeightManager.h12),
        CustomTextFormField(
          maxLines: 3,
          controller: controllerGroupDesc,
          hintText: ConstValue.kNote,
        ),
        VerticalSpace(HeightManager.h12),
        StreamBuilder(
            stream: outPathImage,
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CupertinoActivityIndicator(),
                    )
                  : snapshot.data != null && snapshot.data!.trim() != ""
                      ? Stack(
                          children: [
                            DottedBorder(
                              dashPattern: const [10, 10],
                              radius: Radius.circular(RadiusValuesManager.br12),
                              borderType: BorderType.RRect,
                              color: ColorManager.kPrimaryColor,
                              padding: EdgeInsets.all(PaddingManager.ph4),
                              strokeWidth: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(RadiusValuesManager.br4)),
                                child: Image.file(
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Text(
                                      "not found",
                                      style: TextStyle(color: Colors.white),
                                    );
                                  },
                                  File(snapshot.data!),
                                  width: double.infinity,
                                  height: HeightManager.h200,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            IconButton.filled(
                              onPressed: onPressedDeleteImage,
                              icon: const Icon(Icons.delete),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorManager.kPrimaryColor
                                      .withOpacity(.3)),
                            ),
                          ],
                        )
                      : InkWell(
                          onTap: onPressedPickImage,
                          child: Container(
                            height: HeightManager.h200,
                            width: double.infinity,
                            color: ColorManager.kPrimaryColor.withOpacity(.1),
                            child: DottedBorder(
                              dashPattern: const [10, 10],
                              radius: Radius.circular(RadiusValuesManager.br12),
                              borderType: BorderType.RRect,
                              color: ColorManager.kPrimaryColor,
                              padding: EdgeInsets.all(PaddingManager.ph8),
                              strokeWidth: 1,
                              child: SizedBox(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.upload_file_sharp,
                                      size: FontsSize.f30,
                                      color: ColorManager.kWhiteColor,
                                    ),
                                    VerticalSpace(HeightManager.h5),
                                    Text(
                                      ConstValue.kChooseFile,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: FontsName.geDinerOneFont,
                                        fontSize: FontsSize.f14,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
            }),
      ],
    );
  }
}
