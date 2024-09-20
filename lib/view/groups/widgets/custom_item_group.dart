import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/resources/margin_manager.dart';
import 'package:drosak_m_app/core/resources/padding_manager.dart';
import 'package:drosak_m_app/core/resources/radius_values_manager.dart';
import 'package:drosak_m_app/core/resources/width_manager.dart';
import 'package:drosak_m_app/core/widgets/space/horizontal_space.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:drosak_m_app/model/groups/groups_info_model.dart';
import 'package:flutter/material.dart';

class CustomItemGroup extends StatelessWidget {
  const CustomItemGroup({
    super.key,
    required this.groupInfoModel,
    required this.deleteFun,
    required this.editFun,
  });

  final GroupInfoModel groupInfoModel;
  final void Function(GroupInfoModel itemStageModel) deleteFun;
  final void Function(GroupInfoModel itemStageModel) editFun;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 2,
          top: -20,
          child: Center(
            child: CircleAvatar(
              backgroundColor: ColorManager.kPrimaryColor,
              child: Text(
                groupInfoModel.groupDetails.id.toString(),
                style: TextStyle(
                  color: ColorManager.kWhiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: FontsSize.f15,
                ),
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: ColorManager.kPrimaryColor,
                blurRadius: 5,
                blurStyle: BlurStyle.outer,
                offset: Offset(0, 0),
                spreadRadius: 1,
              )
            ],
            borderRadius:
                BorderRadius.all(Radius.circular(RadiusValuesManager.br18)),
            border: Border.all(color: ColorManager.kPrimaryColor),
          ),
          margin: EdgeInsets.symmetric(horizontal: MarginManager.mw16),
          child: Padding(
            padding: EdgeInsets.only(
              right: PaddingManager.pw22,
              left: PaddingManager.pw10,
              top: PaddingManager.ph6,
              bottom: PaddingManager.ph6,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              groupInfoModel.groupDetails.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontsSize.f16,
                                  color: ColorManager.kWhiteColor,
                                  fontFamily: FontsName.geDinerOneFont),
                            ),
                          ),
                          HorizontalSpace(WidthManager.w6),
                          PopupMenuButton(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text(
                                  ConstValue.kEdit,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: FontsSize.f16,
                                      color: ColorManager.kBlackColor,
                                      fontFamily: FontsName.geDinerOneFont),
                                ),
                                onTap: () {
                                  editFun(groupInfoModel);
                                },
                              ),
                              PopupMenuItem(
                                child: Text(ConstValue.kDelete,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FontsSize.f16,
                                        color: ColorManager.kBlackColor,
                                        fontFamily:
                                            FontsName.geDinerOneFont)),
                                onTap: () {
                                  deleteFun(groupInfoModel);
                                },
                              ),
                            ],
                            child: const Icon(
                              Icons.more_vert,
                              color: ColorManager.kWhiteColor,
                            ),
                          ),
                        ],
                      ),
                      VerticalSpace(HeightManager.h12),
                      Table(
                        border: TableBorder.all(
                            color: ColorManager.kWhiteColor,
                            borderRadius: BorderRadius.all(
                                Radius.circular(RadiusValuesManager.br14))),
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                                color: ColorManager.kPrimaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      RadiusValuesManager.br14),
                                  topRight: Radius.circular(
                                      RadiusValuesManager.br14),
                                )),
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: PaddingManager.pw4,
                                    vertical: PaddingManager.ph4),
                                child: const Center(
                                  child: Text(
                                    ConstValue.kDay,
                                    style: TextStyle(
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
                                        color: ColorManager.kWhiteColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          for (int i = 0;
                              i < groupInfoModel.listAppointment.length;
                              i++)
                            TableRow(children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: PaddingManager.pw4,
                                    vertical: PaddingManager.ph10),
                                child: Center(
                                  child: Text(
                                    groupInfoModel.listAppointment[i].day,
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
                                    groupInfoModel.listAppointment[i].time,
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
                                    groupInfoModel.listAppointment[i].ms,
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
                      VerticalSpace(HeightManager.h5),
                      Row(
                        children: [
                          HorizontalSpace(WidthManager.w3),
                          Expanded(
                            child: Text(
                              groupInfoModel.groupDetails.desc,
                              style: TextStyle(
                                  color: ColorManager.kWhiteColor
                                      .withOpacity(.6),
                                  fontFamily: FontsName.geDinerOneFont,
                                  fontSize: FontsSize.f10),
                            ),
                          ),
                        ],
                      ),
                      // if (itemStageModel.createdAt != null)
                      //   Text(
                      //     itemStageModel.createdAt!,
                      //     style: TextStyle(
                      //         color: ColorManager.kWhiteColor.withOpacity(.6),
                      //         fontFamily: FontsName.geDinerOneFont,
                      //         fontSize: FontsSize.f9),
                      //   )
                    ],
                  ),
                ),
                HorizontalSpace(WidthManager.w7),
                // ClipRRect(
                //   borderRadius: BorderRadius.all(
                //       Radius.circular(RadiusValuesManager.br50)),
                //   child: Image.file(
                //     errorBuilder: (context, error, stackTrace) =>
                //         SvgPicture.asset(
                //       Assets.assetsImagesPlaceholderSvg,
                //       width: WidthManager.w50,
                //     ),
                //     File('itemStageModel.image'),
                //     height: HeightManager.h50,
                //     width: WidthManager.w50,
                //   ),
                // )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
