import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:drosak_m_app/model/groups/groups_info_model.dart';
import 'package:drosak_m_app/model/student_model.dart';
import 'package:drosak_m_app/view/groups/widgets/custom_item_group.dart';
import 'package:drosak_m_app/view/students/widgets/custom_item_student.dart';
import 'package:flutter/cupertino.dart';

class CustomListSearchStudentScreen extends StatelessWidget {
  const CustomListSearchStudentScreen(
      {super.key,
      required this.getSearchItemStudent,
      required this.deleteFun,
      required this.editFun});

  final Future<List<StudentModel>> getSearchItemStudent;
  final void Function(StudentModel studentModel) deleteFun;
  final void Function(StudentModel studentModel) editFun;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StudentModel>>(
        future: getSearchItemStudent,
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CupertinoActivityIndicator(
                  color: ColorManager.kPrimaryColor,
                ))
              : Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      VerticalSpace(HeightManager.h24),
                      Expanded(
                        child: ListView.separated(
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
                      ),
                    ],
                  ),
                );
        });
  }
}
