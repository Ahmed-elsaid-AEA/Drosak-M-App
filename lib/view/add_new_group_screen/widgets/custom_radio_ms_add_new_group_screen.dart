import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/width_manager.dart';
import 'package:drosak_m_app/core/widgets/buttons/custom_material_button.dart';
import 'package:drosak_m_app/core/widgets/space/horizontal_space.dart';
import 'package:flutter/material.dart';

class CustomRadioMSAddNewGroupScreen extends StatelessWidget {
  const CustomRadioMSAddNewGroupScreen({
    super.key,
    required this.onPressedSelectTime,
    required this.groupValueMS,
    required this.onChangedMSValue,
  });

  final VoidCallback onPressedSelectTime;
  final String groupValueMS;
  final ValueChanged<String?> onChangedMSValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          ConstValue.kTime,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: FontsName.geDinerOneFont,
            color: ColorManager.kWhiteColor,
          ),
        ),
        HorizontalSpace(WidthManager.w9),
        CustomMaterialButton(
            onPressed: onPressedSelectTime, text: ConstValue.kChooseTime),
        Expanded(
          child: RadioListTile(
            title: const Text(
              ConstValue.kPM,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: FontsName.geDinerOneFont,
                color: ColorManager.kWhiteColor,
              ),
            ),
            value: ConstValue.kPM,
            groupValue: groupValueMS,
            onChanged: onChangedMSValue,
          ),
        ),
        Expanded(
          child: RadioListTile(
            title: const Text(
              ConstValue.kAM,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: FontsName.geDinerOneFont,
                color: ColorManager.kWhiteColor,
              ),
            ),
            value: ConstValue.kAM,
            groupValue: groupValueMS,
            onChanged: onChangedMSValue,
          ),
        )
      ],
    );
  }
}
