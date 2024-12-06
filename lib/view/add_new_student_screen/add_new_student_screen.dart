
import 'package:drosak_m_app/controller/add_new_group_screen_controller/add_new_group_screen_controller.dart';
import 'package:drosak_m_app/controller/add_new_students_screen_controller/add_new_students_screen_controller.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/view/add_new_group_screen/widgets/custom_body_add_new_group_screen.dart';
import 'package:drosak_m_app/view/add_new_student_screen/widgets/custom_body_add_new_students_screen.dart';

import 'package:flutter/material.dart';

import '../add_new_group_screen/widgets/custom_app_bar_add_new_group_screen.dart';

class AddNewStudentsScreen extends StatefulWidget {
  const AddNewStudentsScreen({super.key});

  @override
  State<AddNewStudentsScreen> createState() => _AddNewStudentsScreenState();
}

class _AddNewStudentsScreenState extends State<AddNewStudentsScreen> {
  late AddNewStudentsScreenController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AddNewStudentsScreenController(context);
  }

  @override
  Widget build(BuildContext context) {
    _controller.getArgumentFromLastScreen(context);
    return Scaffold(
      appBar: CustomAppBarAddNewGroupScreen(
          textAddOrEdit: _controller.status == ConstValue.kAddNewStudent
              ? ConstValue.kSaveAll
              : ConstValue.kEdit,
          onPressed: () {
            _controller.onPressedAtEditORSave();
          },
          title: _controller.status),
      body: CustomBodyAddNewStudentsScreen(
        controller: _controller,
      ),
    );
  }
}
