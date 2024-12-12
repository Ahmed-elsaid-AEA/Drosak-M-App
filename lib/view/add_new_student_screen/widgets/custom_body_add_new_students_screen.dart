import 'package:drosak_m_app/controller/add_new_group_screen_controller/add_new_group_screen_controller.dart';
import 'package:drosak_m_app/controller/add_new_students_screen_controller/add_new_students_screen_controller.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/padding_manager.dart';
import 'package:drosak_m_app/view/add_new_group_screen/widgets/custom_add_time_and_day_of_add_new_group_screen.dart';
import 'package:drosak_m_app/view/add_new_group_screen/widgets/custom_group_details_add_new_group_screen.dart';
import 'package:drosak_m_app/view/add_new_group_screen/widgets/custom_select_education_stage_name_add_new_group_screen.dart';
import 'package:drosak_m_app/view/add_new_student_screen/widgets/custom_select_group_name_add_new_student_screen.dart';
import 'package:drosak_m_app/view/add_new_student_screen/widgets/custom_show_time_and_day_of_this_group_add_new_students_screen.dart';
import 'package:drosak_m_app/view/add_new_student_screen/widgets/custom_student_details_add_new_student_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBodyAddNewStudentsScreen extends StatelessWidget {
  const CustomBodyAddNewStudentsScreen({
    super.key,
    required this.controller,
  });

  final AddNewStudentsScreenController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: PaddingManager.pw12, vertical: PaddingManager.ph22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomGroupDetailsAddNewStudentScreen(
              onPressedPickImage: controller.onPressedPickImage,
              controllerGroupDesc: controller.controllerStudentNote,
              controllerStudentName: controller.controllerStudentName,
              formStateStudentDetails: controller.formStateStudentDetails,
              outPathImage: controller.outPutPathImage,
              onPressedDeleteImage: () {
                controller.onPressedDeleteImage();
              },
            ),
            CustomSelectEducationStageNameAddNewGroupScreen(
              initialItem: controller.selectedEducationStage,
              outPutDataListItemStageModel:
                  controller.outPutDataListItemStageModel,
              onChanged: controller.onChangedSelectEducationStageName,
              outPutDataInitialItem:
                  controller.outPutDataInitialItemSelectedStage,
            ),
            CustomSelectGroupNameAddNewGroupScreen(
              initialItem: controller.selectedGroupDetails,
              outPutDataListItemGroupsDetails:
                  controller.outPutDataListItemGroupsDetails,
              onChanged: controller.onChangedSelectGroupsName,
              outPutDataInitialSelectedGroup:
                  controller.outPutDataInitialItemSelectedGroup,
              // outPutDataInitialItem: controller.outPutDataInitialItem,
            ),
            CustomShowTimeAndDayOfThisGroupAddNewStudentsScreen(
              outPutListTimeDayGroupModel: controller.outPutDataListAppointment,
            ),

          ],
        ),
      ),
    ));
  }
}
