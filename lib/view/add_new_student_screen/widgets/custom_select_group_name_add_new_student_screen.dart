import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/resources/width_manager.dart';
import 'package:drosak_m_app/core/widgets/space/horizontal_space.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:drosak_m_app/model/groups/group_details.dart';
import 'package:flutter/material.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';

class CustomSelectGroupNameAddNewGroupScreen extends StatelessWidget {
  const CustomSelectGroupNameAddNewGroupScreen(
      {super.key,
      required this.outPutDataListItemGroupsDetails,
      required this.onChanged,
      this.initialItem,
      required this.outPutDataInitialSelectedGroup});

  final Function(GroupDetails?)? onChanged;
  final Stream<List<GroupDetails>> outPutDataListItemGroupsDetails;
  final Stream<GroupDetails?> outPutDataInitialSelectedGroup;
  final GroupDetails? initialItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder2<List<GroupDetails>, GroupDetails?>(
          streams: StreamTuple2(
              outPutDataListItemGroupsDetails, outPutDataInitialSelectedGroup),
          builder: (context, snapshots) {
             return CustomDropdown<GroupDetails>.search(
              hintText: snapshots.snapshot1.data == null
                  ? ConstValue.kChooseAntherStageEducation
                  : (snapshots.snapshot1.data!.isEmpty)
                      ? ConstValue.kChooseAntherStageEducation
                      : ConstValue.kChooseGroup,
              items: snapshots.snapshot1.data,
              noResultFoundText: ConstValue.kFirstSelectEducationStageName,
              initialItem: snapshots.snapshot2.data,
              listItemBuilder: (context, item, isSelected, onItemSelect) =>
                  ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  item.name,
                  style: TextStyle(
                      color: ColorManager.kBlackColor, fontSize: FontsSize.f14),
                ),
                subtitle: item.desc.isEmpty ? null : Text(item.desc),
                leading: CircleAvatar(
                    radius: 10,
                    backgroundColor: ColorManager.kPrimaryColor,
                    child: Text(
                      item.id.toString(),
                      style: TextStyle(
                          color: ColorManager.kWhiteColor,
                          fontSize: FontsSize.f9),
                    )),
              ),
              onChanged: onChanged,
              itemsListPadding: EdgeInsets.zero,
              headerBuilder: (context, item, enabled) => Row(
                children: [
                  CircleAvatar(
                      radius: 10,
                      backgroundColor: ColorManager.kPrimaryColor,
                      child: Text(
                        item.id.toString(),
                        style: TextStyle(
                            color: ColorManager.kWhiteColor,
                            fontSize: FontsSize.f9),
                      )),
                  HorizontalSpace(WidthManager.w15),
                  Expanded(
                      child: Text(
                    item.name,
                    style: TextStyle(
                        color: ColorManager.kBlackColor,
                        fontSize: FontsSize.f14),
                    maxLines: 1,
                  )),
                ],
              ),
            );
          },
        ),
        VerticalSpace(HeightManager.h16),
      ],
    );
  }
}
