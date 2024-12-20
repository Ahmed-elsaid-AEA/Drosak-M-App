import 'dart:async';
import 'dart:developer';

import 'package:drosak_m_app/core/database/sqlite/students_operation.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/routes_mananger.dart';
import 'package:drosak_m_app/core/widgets/search/custom_search_delegate.dart';
import 'package:drosak_m_app/model/groups/appointment_model.dart';
import 'package:drosak_m_app/model/groups/group_details.dart';
import 'package:drosak_m_app/model/groups/groups_info_model.dart';
import 'package:drosak_m_app/model/student_model.dart';
import 'package:drosak_m_app/view/groups/widgets/search/custom_list_search_group_screen.dart';
import 'package:drosak_m_app/view/students/widgets/search/custom_list_search_group_screen.dart';
import 'package:flutter/material.dart';

class StudentController {
  late StreamController<List<StudentModel>> controllerListItemStudentModel;
  late Sink<List<StudentModel>> inputDataListItemStudentModel;
  late Stream<List<StudentModel>> outPutDataListItemStudentModel;
  BuildContext context;

  bool isSearchNow=false;

  StudentController(this.context) {
    start();
  }

  void start() async {
    await initControllers();
    await getAllData();
  }

  Future<void> getAllData() async {
    StudentOperation studentOperation = StudentOperation();
    List<StudentModel> listStudentModel =
        await studentOperation.getStudentsInfo();
    inputDataListItemStudentModel.add(listStudentModel);
  }

  Future<void> initControllers() async {
    controllerListItemStudentModel = StreamController();
    inputDataListItemStudentModel = controllerListItemStudentModel.sink;
    outPutDataListItemStudentModel =
        controllerListItemStudentModel.stream.asBroadcastStream();
  }

  Future<void> disposeControllers() async {
    controllerListItemStudentModel.close();
    inputDataListItemStudentModel.close();
  }

  void addNewStudents({required BuildContext context}) {
    Navigator.of(context)
        .pushNamed(RoutesName.kAddNewStudentsScreen,
            arguments: ConstValue.kAddNewStudent)
        .then((value) => getAllData());
  }

  void onTapDelete(StudentModel studentModel) async {
    StudentOperation studentOperation = StudentOperation();
    bool deleted = await studentOperation.deleteStudent(studentModel.id!);
    if (deleted == true) {
      if(isSearchNow==true){
        Navigator.of(context).pop();
      }
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(ConstValue.kDeletedStudentSucces)));
      onTapRefresh();
    }
  }

  void onTapRefresh() {
    inputDataListItemStudentModel.add([]);
    getAllData();
  }

  void onTapEdit(StudentModel studentModel) {
    Navigator.of(context).pushNamed(
      RoutesName.kAddNewStudentsScreen,
      arguments: {
        ConstValue.kStatus: ConstValue.kEditThisStudent,
        ConstValue.kStudentModel: studentModel
      },
    ).then((value) {
      if(isSearchNow==true){
        Navigator.of(context).pop();
      }
      onTapRefresh();
    });
  }

  void onPressedSearch() {
    isSearchNow = true;
    showSearch(
        context: context,
        delegate: CustomSearchDelegated(
          myBuildResult: (String query) {
            StudentOperation studentOperation = StudentOperation();
            return query == ''
                ? const SizedBox()
                : CustomListSearchStudentScreen(
                    getSearchItemStudent:
                        studentOperation.getStudentsInfo(studentName: query),
                    editFun: (groupInfoModel) {
                      onTapEdit(groupInfoModel);
                    },
                    deleteFun: (groupInfoModel) {
                      onTapDelete(groupInfoModel);
                    },
                  );
          },
        )).then((value) {
          return isSearchNow = false;
        });
  }
}
