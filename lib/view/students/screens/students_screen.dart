import 'package:drosak_m_app/controller/student/student_controller.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/widgets/app_bar/custom_app_bar_title_add_search.dart';
import 'package:drosak_m_app/model/groups/appointment_model.dart';
import 'package:drosak_m_app/model/groups/group_details.dart';
import 'package:drosak_m_app/model/groups/groups_info_model.dart';
import 'package:drosak_m_app/model/student_model.dart';
import 'package:drosak_m_app/view/audience/widgets/custom_item_audience_screen.dart';
import 'package:drosak_m_app/view/groups/widgets/custom_list_view_item_groups.dart';
import 'package:drosak_m_app/view/students/widgets/custom_item_student.dart';
import 'package:drosak_m_app/view/students/widgets/custom_list_view_item_students.dart';
import 'package:flutter/material.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  late StudentController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = StudentController(context);
  }

  @override
  void dispose() {
    _controller.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBarTitleAddSearch(
              title: ConstValue.kStudents,
              onPressedSearch: () {
                _controller.onPressedSearch();
              },
              onPressedAdd: () {
                _controller.addNewStudents(context: context);
              },
              streamCount: _controller.outPutDataListItemStudentModel,
            ),
            CustomListViewItemsStudents(
              outPutDataListItemStudentModel:
                  _controller.outPutDataListItemStudentModel,
              deleteFun: _controller.onTapDelete,
              editFun: _controller.onTapEdit,
              onRefresh: () {
                _controller.onTapRefresh();
              },
            ),

          ],
        ),
      ),
    );
  }
}
