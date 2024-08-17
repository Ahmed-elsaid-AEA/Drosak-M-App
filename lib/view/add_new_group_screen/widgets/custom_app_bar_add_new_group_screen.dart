 import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:flutter/material.dart';

class CustomAppBarAddNewGroupScreen extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarAddNewGroupScreen(
      {super.key,
        required this.textAddOrEdit,
        required this.onPressed,
        required this.title});

  final String textAddOrEdit;
  final String title;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(textAddOrEdit,
              style: TextStyle(
                  color: ColorManager.kWhiteColor,
                  fontWeight: FontWeight.bold,
                  fontSize: FontsSize.f14,
                  fontFamily: FontsName.geDinerOneFont)),
        )
      ],
      title: Text(
        title,
        style: TextStyle(
            color: ColorManager.kWhiteColor,
            fontSize: FontsSize.f16,
            fontWeight: FontWeight.bold,
            fontFamily: FontsName.geDinerOneFont),
      ),
      backgroundColor: ColorManager.kPrimaryColor,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
