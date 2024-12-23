import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/resources/padding_manager.dart';
import 'package:drosak_m_app/core/resources/radius_values_manager.dart';
import 'package:drosak_m_app/core/widgets/buttons/custom_material_button.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:drosak_m_app/model/student_model.dart';
import 'package:flutter/material.dart';

class CustomAddNewAudienceScreen extends StatelessWidget {
  const CustomAddNewAudienceScreen({
    super.key,
    required this.onPressedAdd,
    this.edit = false,
    required this.listStudentModel,
  });

  final VoidCallback onPressedAdd;
  final bool edit;
  final List<StudentModel> listStudentModel;

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
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => CustomItem(
                          studentModel: listStudentModel[index],
                        ),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: listStudentModel.length),
                VerticalSpace(HeightManager.h12),
                VerticalSpace(HeightManager.h24),
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

class CustomItem extends StatelessWidget {
  const CustomItem({
    super.key,
    required this.studentModel,
  });

  final StudentModel studentModel;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        studentModel.name,
        style: const TextStyle(color: ColorManager.kWhiteColor),
      ),
       value: true, onChanged: (bool? value) {  },
    );
  }
}
