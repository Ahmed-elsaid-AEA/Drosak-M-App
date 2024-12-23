import 'dart:io';

import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/resources/padding_manager.dart';
import 'package:drosak_m_app/core/resources/radius_values_manager.dart';
import 'package:drosak_m_app/core/resources/width_manager.dart';
import 'package:drosak_m_app/core/widgets/buttons/custom_material_button.dart';
import 'package:drosak_m_app/core/widgets/space/horizontal_space.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:drosak_m_app/model/student_model.dart';
import 'package:flutter/material.dart';

class CustomAddNewAudienceScreen extends StatelessWidget {
  const CustomAddNewAudienceScreen({
    super.key,
    required this.onPressedAdd,
    required this.listStudentModel,
    required this.outPutMapSelectedStudent,
    required this.onChangedSelectedStatus,
    required this.onPressedSelectedDateTime,
  });

  final Stream<Map<String, bool?>> outPutMapSelectedStudent;

  final VoidCallback onPressedAdd;
  final List<StudentModel> listStudentModel;
  final void Function({required int id, required bool status})
      onChangedSelectedStatus;
  final VoidCallback onPressedSelectedDateTime;

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
                StreamBuilder<Map<String, bool?>>(
                  stream: outPutMapSelectedStudent,
                  builder:
                      (context, AsyncSnapshot<Map<String, bool?>> snapshot) {
                    //?count of true
                    int countSelected = 0;
                    if (snapshot.data != null) {
                      countSelected = snapshot.data!.values
                          .where((element) => element == true)
                          .toList()
                          .length;
                    } else {
                      countSelected = 0;
                    }
                    return Text(
                      countSelected.toString(),
                      style: const TextStyle(color: ColorManager.kWhiteColor),
                    );
                  },
                ),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => StreamBuilder(
                        stream: outPutMapSelectedStudent,
                        builder: (context, snapshot) => CustomItem(
                              onChangedSelectedStatus: (value) {
                                onChangedSelectedStatus(
                                    id: listStudentModel[index].id!,
                                    status: value!);
                              },
                              studentModel: listStudentModel[index],
                              selected: snapshot.data == null
                                  ? false
                                  : snapshot.data![
                                      listStudentModel[index].id.toString()],
                            )),
                    separatorBuilder: (context, index) =>
                        Divider(color: ColorManager.kGrey1.withOpacity(.5)),
                    itemCount: listStudentModel.length),
                VerticalSpace(HeightManager.h24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomMaterialButton(
                        onPressed: onPressedAdd, text: ConstValue.kAdd),
                    HorizontalSpace(WidthManager.w6),
                    TextButton(
                      onPressed: onPressedSelectedDateTime,
                      style: TextButton.styleFrom(
                        foregroundColor: ColorManager.kWhiteColor,
                        textStyle: TextStyle(
                            color: ColorManager.kWhiteColor,
                            fontSize: FontsSize.f16,
                            fontFamily: FontsName.geDinerOneFont),
                      ),
                      child: const Text(ConstValue.kSelectDate),
                    ),
                  ],
                )
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
    required this.selected,
    this.onChangedSelectedStatus,
  });

  final StudentModel studentModel;
  final bool? selected;
  final ValueChanged<bool?>? onChangedSelectedStatus;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        studentModel.name,
        style: const TextStyle(color: ColorManager.kWhiteColor),
      ),
      subtitle: Text(
        studentModel.id!.toString(),
        style: TextStyle(color: ColorManager.kWhiteColor.withOpacity(.5)),
      ),
      secondary: ClipRRect(
        borderRadius:
            BorderRadius.all(Radius.circular(RadiusValuesManager.br4)),
        child: Image.file(
          errorBuilder: (context, error, stackTrace) {
            return const Text(
              "not found",
              style: TextStyle(color: Colors.white),
            );
          },
          File(studentModel.image),
          // width: double.infinity,
          height: HeightManager.h200,
          fit: BoxFit.contain,
        ),
      ),
      value: selected ?? false,
      onChanged: onChangedSelectedStatus,
    );
  }
}
//? {
//  1 : true
// }
