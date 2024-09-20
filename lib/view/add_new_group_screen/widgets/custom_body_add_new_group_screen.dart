import 'package:drosak_m_app/controller/add_new_group_screen_controller/add_new_group_screen_controller.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/padding_manager.dart';
import 'package:drosak_m_app/view/add_new_group_screen/widgets/custom_add_time_and_day_of_add_new_group_screen.dart';
import 'package:drosak_m_app/view/add_new_group_screen/widgets/custom_group_details_add_new_group_screen.dart';
import 'package:drosak_m_app/view/add_new_group_screen/widgets/custom_select_education_stage_name_add_new_group_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBodyAddNewGroupScreen extends StatelessWidget {
  const CustomBodyAddNewGroupScreen({
    super.key,
    required this.controller,
  });

  final AddNewGroupScreenController controller;

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
            CustomGroupDetailsAddNewGroupScreen(
              controllerGroupDesc: controller.controllerGroupDesc,
              controllerGroupName: controller.controllerGroupName,
              formStateGroupDetails: controller.formStateGroupDetails,
            ),
            CustomSelectEducationStageNameAddNewGroupScreen(
                initialItem: controller.selectedEducationStage,
                outPutDataListItemStageModel:
                    controller.outPutDataListItemStageModel,
                onChanged: controller.onChangedSelectEducationStageName,
              outPutDataInitialItem: controller.outPutDataInitialItem,),
            CustomAddTimeAndDayOfAddNewGroupScreen(
              onChangedMSValue: controller.onChangedMSValue,
              onPressedSelectTime: () {
                controller.onPressedSelectTime();
              },
              onChangedSelectDay: controller.onChangedSelectDay,
              onPressedAddTimeAndDayToTable: () {
                controller.onPressedAddTimeAndDayToTable(context);
              },
              outPutListTimeDayGroupModel:
                  controller.outPutDataListTimeDayGroupModel,
              outPutTime: controller.outPutDataSelectedTime,
              listDay: ConstListValues.listDays,
              outPutDataMsValue: controller.outPutDataMsValue,
              onPressedDeleteAppointment: controller.onPressedDeleteAppointment,
            ),
            // StreamBuilder(
            //     stream: outPathImage,
            //     builder: (context, snapshot) {
            //       return snapshot.connectionState == ConnectionState.waiting
            //           ? const Center(
            //         child: CupertinoActivityIndicator(),
            //       )
            //           : snapshot.data != null
            //           ? Column(
            //         children: [
            //           Stack(
            //             children: [
            //               Image.file(
            //                 errorBuilder:
            //                     (context, error, stackTrace) {
            //                   return const Text(
            //                     "not found",
            //                     style: TextStyle(
            //                         color: Colors.white),
            //                   );
            //                 },
            //                 File(snapshot.data!),
            //                 width: double.infinity,
            //                 fit: BoxFit.cover,
            //               ),
            //               IconButton.filled(
            //                 onPressed: onPressedDeleteImage,
            //                 icon: const Icon(Icons.delete),
            //                 style: ElevatedButton.styleFrom(
            //                     backgroundColor: Colors.red),
            //               ),
            //             ],
            //           ),
            //           VerticalSpace(HeightManager.h24),
            //         ],
            //       )
            //           : const SizedBox();
            //     }),
          ],
        ),
      ),
    ));
  }
}
