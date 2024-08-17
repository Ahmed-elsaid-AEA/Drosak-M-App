import 'package:drosak_m_app/controller/add_new_group_screen_controller/add_new_group_screen_controller.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:flutter/material.dart';

import 'widgets/custom_app_bar_add_new_group_screen.dart';

class AddNewGroupScreen extends StatefulWidget {
  const AddNewGroupScreen({super.key});

  @override
  State<AddNewGroupScreen> createState() => _AddNewGroupScreenState();
}

class _AddNewGroupScreenState extends State<AddNewGroupScreen> {
  late AddNewGroupScreenController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AddNewGroupScreenController();
  }

  @override
  Widget build(BuildContext context) {
    _controller.getArgumentFromLastScreen(context);
    return Scaffold(
        appBar: CustomAppBarAddNewGroupScreen(
            textAddOrEdit: _controller.status == ConstValue.kAddNewGroup
                ? ConstValue.kAdd
                : ConstValue.kEdit,
            onPressed: () {},
            title: _controller.status));
  }
}

