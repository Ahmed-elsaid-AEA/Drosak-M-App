import 'dart:io';

import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
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
import 'package:drosak_m_app/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomItemStudent extends StatelessWidget {
  const CustomItemStudent({
    super.key,
    required this.studentModel,
    required this.deleteFun,
    required this.editFun,
  });

  final StudentModel studentModel;
  final void Function(StudentModel itemStageModel) deleteFun;
  final void Function(StudentModel itemStageModel) editFun;

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
                studentModel.id.toString(),
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
                          CustomEditAndDeletePopupMenuButton(
                              editFun: editFun,
                              studentModel: studentModel,
                              deleteFun: deleteFun),
                          Expanded(
                            child: Text(
                              studentModel.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: FontsSize.f16,
                                  color: ColorManager.kWhiteColor,
                                  fontFamily: FontsName.geDinerOneFont),
                            ),
                          ),
                          HorizontalSpace(WidthManager.w6),
                          ClipRRect(
                            borderRadius: BorderRadius.all(
                                Radius.circular(RadiusValuesManager.br50)),
                            child: Image.file(
                              errorBuilder: (context, error, stackTrace) =>
                                  SvgPicture.asset(
                                AssetsValuesManager.assetsImagesPlaceholderSvg,
                                width: WidthManager.w50,
                              ),
                              File(
                                studentModel.image,
                              ),
                              height: HeightManager.h50,
                              width: WidthManager.w50,
                            ),
                          ),
                        ],
                      ),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text: studentModel.educationName,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: FontsSize.f13,
                              color: ColorManager.kWhiteColor,
                              fontFamily: FontsName.geDinerOneFont),
                        ),
                        TextSpan(
                          text: ' / ',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: FontsSize.f14,
                              decoration: TextDecoration.underline,
                              color: ColorManager.kRedColor,
                              fontFamily: FontsName.geDinerOneFont),
                        ),
                        TextSpan(
                          text: studentModel.groupName,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: FontsSize.f13,
                              color: ColorManager.kWhiteColor,
                              fontFamily: FontsName.geDinerOneFont),
                        ),
                      ])),

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
                                  topLeft:
                                      Radius.circular(RadiusValuesManager.br14),
                                  topRight:
                                      Radius.circular(RadiusValuesManager.br14),
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
                              i < studentModel.listAppointmentModel!.length;
                              i++)
                            TableRow(children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: PaddingManager.pw4,
                                    vertical: PaddingManager.ph10),
                                child: Center(
                                  child: Text(
                                    studentModel.listAppointmentModel![i].day,
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
                                    studentModel.listAppointmentModel![i].time,
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
                                    studentModel.listAppointmentModel![i].ms,
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
                              studentModel.note,
                              style: TextStyle(
                                  color:
                                      ColorManager.kWhiteColor.withOpacity(.6),
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

class CustomEditAndDeletePopupMenuButton extends StatelessWidget {
  const CustomEditAndDeletePopupMenuButton({
    super.key,
    required this.editFun,
    required this.studentModel,
    required this.deleteFun,
  });

  final void Function(StudentModel itemStageModel) editFun;
  final StudentModel studentModel;
  final void Function(StudentModel itemStageModel) deleteFun;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
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
            editFun(studentModel);
          },
        ),
        PopupMenuItem(
          child: Text(ConstValue.kDelete,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: FontsSize.f16,
                  color: ColorManager.kBlackColor,
                  fontFamily: FontsName.geDinerOneFont)),
          onTap: () {
            deleteFun(studentModel);
          },
        ),
      ],
      child: const Icon(
        Icons.more_vert,
        color: ColorManager.kWhiteColor,
      ),
    );
  }
}
