import 'dart:developer';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:drosak_m_app/controller/add_new_group_screen_controller/add_new_group_screen_controller.dart';
import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/resources/padding_manager.dart';
import 'package:drosak_m_app/core/resources/radius_values_manager.dart';
import 'package:drosak_m_app/core/resources/width_manager.dart';
import 'package:drosak_m_app/core/widgets/buttons/custom_material_button.dart';
import 'package:drosak_m_app/core/widgets/input_field/custom_text_form_field.dart';
import 'package:drosak_m_app/core/widgets/space/horizontal_space.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:drosak_m_app/view/add_new_group_screen/widgets/custom_app_bar_add_new_group_screen.dart';
import 'package:drosak_m_app/view/add_new_group_screen/widgets/custom_body_add_new_group_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


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
    _controller = AddNewGroupScreenController(context);
  }

  @override
  Widget build(BuildContext context) {
    _controller.getArgumentFromLastScreen(context);
    return Scaffold(
      appBar: CustomAppBarAddNewGroupScreen(
          textAddOrEdit: _controller.status == ConstValue.kAddNewGroup
              ? ConstValue.kSaveAll
              : ConstValue.kEdit,
          onPressed: () {
            _controller.onPressedAtEditORSave();

          },
          title: _controller.status),
      body: CustomBodyAddNewGroupScreen(
        controller: _controller,
      ),
    );
  }
}
