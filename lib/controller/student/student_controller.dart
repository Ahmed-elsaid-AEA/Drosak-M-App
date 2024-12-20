import 'dart:async';
import 'dart:developer';

import 'package:drosak_m_app/core/database/sqlite/students_operation.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/routes_mananger.dart';
import 'package:drosak_m_app/model/groups/appointment_model.dart';
import 'package:drosak_m_app/model/groups/group_details.dart';
import 'package:drosak_m_app/model/groups/groups_info_model.dart';
import 'package:drosak_m_app/model/student_model.dart';
import 'package:flutter/material.dart';

class StudentController {
  late StreamController<List<StudentModel>> controllerListItemStudentModel;
  late Sink<List<StudentModel>> inputDataListItemStudentModel;
  late Stream<List<StudentModel>> outPutDataListItemStudentModel;
  BuildContext context;

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
      onTapRefresh();
    });
  }
}
