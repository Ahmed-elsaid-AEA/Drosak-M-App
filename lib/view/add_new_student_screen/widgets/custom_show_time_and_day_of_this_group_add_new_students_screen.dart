import 'package:animated_custom_dropdown/custom_dropdown.dart';
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
import 'package:drosak_m_app/model/groups/appointment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_radio_ms_add_new_student_screen.dart';

class CustomShowTimeAndDayOfThisGroupAddNewStudentsScreen
    extends StatelessWidget {
  const CustomShowTimeAndDayOfThisGroupAddNewStudentsScreen(
      {super.key,
      required this.listDay,
      required this.outPutTime,
      this.onChangedSelectDay,
      required this.onPressedSelectTime,
      required this.onPressedAddTimeAndDayToTable,
      required this.outPutListTimeDayGroupModel,
      required this.onChangedMSValue,
      required this.outPutDataMsValue,
      required this.onPressedDeleteAppointment});

  final ValueChanged<String?> onChangedMSValue;
  final void Function(int index) onPressedDeleteAppointment;
  final List<String> listDay;
  final Stream<String?> outPutTime;
  final Function(String?)? onChangedSelectDay;
  final VoidCallback onPressedSelectTime;
  final VoidCallback onPressedAddTimeAndDayToTable;
  final Stream<List<AppointmentModel>> outPutListTimeDayGroupModel;
  final Stream<String> outPutDataMsValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VerticalSpace(HeightManager.h12),
        StreamOfCountOfAppointment(
            outPutListTimeDayGroupModel: outPutListTimeDayGroupModel),
        streamOfTable(),
        VerticalSpace(HeightManager.h12),
        streamEmptyOrNot()
      ],
    );
  }

  StreamBuilder<List<AppointmentModel>> streamOfTable() {
    return StreamBuilder(
      stream: outPutListTimeDayGroupModel,
      builder: (context, snapshot) => Table(
        border: TableBorder.all(
            color: ColorManager.kWhiteColor,
            borderRadius:
                BorderRadius.all(Radius.circular(RadiusValuesManager.br14))),
        children: [
          customHeaderOFTable(),
          if (snapshot.data != null)
            for (int i = 0; i < snapshot.data!.length; i++)
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: PaddingManager.pw4,
                      vertical: PaddingManager.ph10),
                  child: Center(
                    child: Text(
                      snapshot.data![i].day,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: FontsName.geDinerOneFont,
                          color: ColorManager.kWhiteColor),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: PaddingManager.pw4,
                      vertical: PaddingManager.ph10),
                  child: Center(
                    child: Text(
                      snapshot.data![i].time,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: FontsName.geDinerOneFont,
                          color: ColorManager.kWhiteColor),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: PaddingManager.pw4,
                      vertical: PaddingManager.ph10),
                  child: Center(
                    child: Text(
                      snapshot.data![i].ms,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: FontsName.geDinerOneFont,
                          color: ColorManager.kWhiteColor),
                    ),
                  ),
                ),
              ])
        ],
      ),
    );
  }

  StreamBuilder<List<AppointmentModel>> streamEmptyOrNot() {
    return StreamBuilder(
      stream: outPutListTimeDayGroupModel,
      builder: (context, snapshot) => snapshot.data == null
          ? const Text(
              ConstValue.kNoTimeAndDayBecauseYouDontChooseGroup,
              style: TextStyle(
                  fontFamily: FontsName.geDinerOneFont,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.kWhiteColor),
            )
          : snapshot.data!.isEmpty
              ? const Text(
                  ConstValue.kNoTimeAndDayBecauseYouDontChooseGroup,
                  style: TextStyle(
                      fontFamily: FontsName.geDinerOneFont,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.kWhiteColor),
                )
              : const SizedBox(),
    );
  }

  TableRow customHeaderOFTable() {
    return TableRow(
      decoration: BoxDecoration(
          color: ColorManager.kPrimaryColor,
          borderRadius:
              BorderRadius.all(Radius.circular(RadiusValuesManager.br14))),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: PaddingManager.pw4, vertical: PaddingManager.ph4),
          child: const Center(
            child: Text(
              ConstValue.kDay,
              style: TextStyle(
                  fontFamily: FontsName.geDinerOneFont,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.kWhiteColor),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: PaddingManager.pw4, vertical: PaddingManager.ph4),
          child: const Center(
            child: Text(
              ConstValue.kTime,
              style: TextStyle(
                  fontFamily: FontsName.geDinerOneFont,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.kWhiteColor),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: PaddingManager.pw4, vertical: PaddingManager.ph4),
          child: const Center(
            child: Text(
              ConstValue.kMS,
              style: TextStyle(
                  fontFamily: FontsName.geDinerOneFont,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.kWhiteColor),
            ),
          ),
        ),
      ],
    );
  }
}

class StreamOfCountOfAppointment extends StatelessWidget {
  const StreamOfCountOfAppointment({
    super.key,
    required this.outPutListTimeDayGroupModel,
  });

  final Stream<List<AppointmentModel>> outPutListTimeDayGroupModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: outPutListTimeDayGroupModel,
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : snapshot.data!.isEmpty
                  ? const SizedBox()
                  : Padding(
                      padding: EdgeInsets.only(
                          bottom: PaddingManager.ph16, top: PaddingManager.ph8),
                      child: Text(
                          "${ConstValue.kCountOfAppointmentAdded} (  ${snapshot.data!.length} ) ",
                          style: TextStyle(
                              fontSize: FontsSize.f20,
                              fontWeight: FontWeight.bold,
                              fontFamily: FontsName.geDinerOneFont,
                              color: ColorManager.kWhiteColor)),
                    ),
    );
  }
}
