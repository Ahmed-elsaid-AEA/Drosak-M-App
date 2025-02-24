import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:drosak_m_app/model/groups/groups_info_model.dart';
import 'package:drosak_m_app/model/student_model.dart';
import 'package:drosak_m_app/view/education_stages/widgets/body/custom_item_stage.dart';
import 'package:drosak_m_app/view/groups/widgets/custom_item_group.dart';
import 'package:drosak_m_app/view/students/widgets/custom_item_student.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListViewItemsStudents extends StatelessWidget {
  const CustomListViewItemsStudents(
      {super.key,
        required this.outPutDataListItemStudentModel,
        required this.deleteFun,
        required this.editFun,
        required this.onRefresh});

  final Stream<List<StudentModel>> outPutDataListItemStudentModel;

  final void Function(StudentModel studentModel) deleteFun;
  final void Function(StudentModel studentModel) editFun;
  final void Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: outPutDataListItemStudentModel,
      builder: (context, snapshot) => Expanded(
        child: RefreshIndicator(
          child: snapshot.connectionState == ConnectionState.waiting
              ? const Center(
              child: CupertinoActivityIndicator(
                color: ColorManager.kPrimaryColor,
              ))
              : ListView.separated(
              itemBuilder: (context, index) =>
              index == snapshot.data!.length
                  ? VerticalSpace(HeightManager.h24)
                  : CustomItemStudent(
                studentModel: snapshot.data![index],
                deleteFun: deleteFun,
                editFun: editFun,
              ),
              separatorBuilder: (context, index) =>
                  VerticalSpace(HeightManager.h24),
              itemCount: snapshot.data!.length + 1),
          onRefresh: () async {
            onRefresh();
          },
        ),
      ),
    );
  }
}
