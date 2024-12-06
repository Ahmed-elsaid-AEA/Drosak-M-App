import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/widgets/input_field/custom_text_form_field.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomGroupDetailsAddNewGroupScreen extends StatelessWidget {
  const CustomGroupDetailsAddNewGroupScreen(
      {super.key,
      required this.formStateGroupDetails,
      required this.controllerGroupName,
      required this.controllerGroupDesc});

  final GlobalKey<FormState> formStateGroupDetails;
  final TextEditingController controllerGroupName;
  final TextEditingController controllerGroupDesc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          ConstValue.kDetailsGroup,
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
                key: formStateGroupDetails,
                child: CustomTextFormField(
                  validator: (value) {
                    if (value == null || value == '') {
                      return ConstValue.kCantEmpty;
                    } else {
                      return null;
                    }
                  },
                  controller: controllerGroupName,
                  hintText: ConstValue.kNameGroup,
                ),
              ),
            ),
            // HorizontalSpace(WidthManager.w6),
            // IconButton.filled(
            //     onPressed: () {},
            //     style: ElevatedButton.styleFrom(
            //         backgroundColor: ColorManager.kPrimaryColor),
            //     icon: SvgPicture.asset(AssetsValuesManager.kPlaceholderSvg)),
          ],
        ),
        VerticalSpace(HeightManager.h12),
        CustomTextFormField(
          maxLines: 3,
          controller: controllerGroupDesc,
          hintText: ConstValue.kDescGroup,
        ),
      ],
    );
  }
}
