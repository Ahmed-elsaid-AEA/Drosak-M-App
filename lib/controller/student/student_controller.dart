import 'dart:async';

import 'package:drosak_m_app/core/database/sqlite/students_operation.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/routes_mananger.dart';
import 'package:drosak_m_app/model/groups/appointment_model.dart';
import 'package:drosak_m_app/model/groups/group_details.dart';
import 'package:drosak_m_app/model/groups/groups_info_model.dart';
import 'package:flutter/material.dart';

class StudentController {
  late StreamController<List<GroupInfoModel>> controllerListItemStudentModel;
  late Sink<List<GroupInfoModel>> inputDataListItemStudentModel;
  late Stream<List<GroupInfoModel>> outPutDataListItemStudentModel;
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
    var a = await studentOperation.getStudentsInfo();
    print(a);

    initAllData();
  }

  void initAllData() {}

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
}
