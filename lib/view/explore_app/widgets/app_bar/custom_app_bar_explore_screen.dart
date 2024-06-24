import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:flutter/material.dart';


class CustomAppBarExploreScreen extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBarExploreScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        ConstValue.kExploreApp,
        style: TextStyle(
            fontSize: FontsSize.f20,
            fontFamily: FontsName.geDinerOneFont,
            color: ColorManager.kPrimaryColor,
            fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
