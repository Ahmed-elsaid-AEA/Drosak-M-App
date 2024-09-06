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
import 'package:drosak_m_app/model/groups/time_day_group_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_radio_ms_add_new_group_screen.dart';

class CustomAddTimeAndDayOfAddNewGroupScreen extends StatelessWidget {
  const CustomAddTimeAndDayOfAddNewGroupScreen(
      {super.key,
      required this.listDay,
      required this.outPutTime,
      this.onChangedSelectDay,
      required this.onPressedSelectTime,
      required this.onPressedAddTimeAndDayToTable,
      required this.listTimeDayGroupModel,
      required this.onChangedMSValue,
      required this.outPutDataMsValue});

  final ValueChanged<String?> onChangedMSValue;

  final List<String> listDay;
  final Stream<String?> outPutTime;
  final Function(String?)? onChangedSelectDay;
  final VoidCallback onPressedSelectTime;
  final VoidCallback onPressedAddTimeAndDayToTable;
  final List<TimeDayGroupModel> listTimeDayGroupModel;
  final Stream<String> outPutDataMsValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text(
              ConstValue.kDay,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: FontsName.geDinerOneFont,
                color: ColorManager.kWhiteColor,
              ),
            ),
            HorizontalSpace(WidthManager.w9),
            Expanded(
              child: CustomDropdown<String>.search(
                hintText: ConstValue.kChooseDay,
                items: listDay,
                noResultFoundText: '',
                // initialItem: "a",
                onChanged: onChangedSelectDay,
              ),
            ),
          ],
        ),
        VerticalSpace(HeightManager.h12),
        StreamBuilder<String>(
          stream: outPutDataMsValue,
          builder: (context, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomRadioMSAddNewGroupScreen(
                      onPressedSelectTime: onPressedSelectTime,
                      groupValueMS: snapshot.data!,
                      onChangedMSValue: onChangedMSValue),
        ),
        VerticalSpace(HeightManager.h12),
        StreamBuilder(
            stream: outPutTime,
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const SizedBox()
                    : snapshot.data == null
                        ? const SizedBox()
                        : Align(
                            alignment: AlignmentDirectional.center,
                            child: Text(
                              snapshot.data!,
                              style:   TextStyle(
                                  fontFamily: FontsName.geDinerOneFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: FontsSize.f20,
                                  color: ColorManager.kWhiteColor),
                            ),
                          )),
        VerticalSpace(HeightManager.h12),
        CustomMaterialButton(
            onPressed: onPressedAddTimeAndDayToTable,
            text: ConstValue.kAddToTableAppointment),
        VerticalSpace(HeightManager.h12),
        Table(
          border: TableBorder.all(
              color: ColorManager.kWhiteColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(RadiusValuesManager.br14))),
          children: [
            TableRow(
              decoration: BoxDecoration(
                  color: ColorManager.kPrimaryColor,
                  borderRadius: BorderRadius.all(
                      Radius.circular(RadiusValuesManager.br14))),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: PaddingManager.pw4,
                      vertical: PaddingManager.ph4),
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
                      horizontal: PaddingManager.pw4,
                      vertical: PaddingManager.ph4),
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
                      horizontal: PaddingManager.pw4,
                      vertical: PaddingManager.ph4),
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
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: PaddingManager.pw4,
                      vertical: PaddingManager.ph4),
                  child: const Center(
                    child: Text(
                      ConstValue.kDelete,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: FontsName.geDinerOneFont,
                          color: ColorManager.kWhiteColor),
                    ),
                  ),
                ),
              ],
            ),
            for (int i = 0; i < listTimeDayGroupModel.length; i++)
              TableRow(children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: PaddingManager.pw4,
                      vertical: PaddingManager.ph10),
                  child: Center(
                    child: Text(
                      listTimeDayGroupModel[i].day,
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
                      listTimeDayGroupModel[i].time,
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
                      listTimeDayGroupModel[i].ms,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: FontsName.geDinerOneFont,
                          color: ColorManager.kWhiteColor),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(CupertinoIcons.delete))
              ])
          ],
        ),
        VerticalSpace(HeightManager.h12),
        if (listTimeDayGroupModel.isEmpty)
          const Text(
            ConstValue.kNoTimeAndDayYetAdd,
            style: TextStyle(
                fontFamily: FontsName.geDinerOneFont,
                fontWeight: FontWeight.bold,
                color: ColorManager.kWhiteColor),
          )
      ],
    );
  }
}
