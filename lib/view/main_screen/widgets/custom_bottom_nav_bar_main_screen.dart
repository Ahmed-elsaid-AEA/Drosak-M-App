import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/resources/colors_manager.dart';
import '../../../model/main_screen/bottom_nav_bar_tab_model.dart';

class CustomBottomNavBarMainScreen extends StatelessWidget {
  const CustomBottomNavBarMainScreen({
    super.key, required this.listIcon,
  });

  final List<BottomNavBarTabModel> listIcon;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: 1,
        unselectedItemColor: ColorManager.kGreyLight,
        selectedItemColor: ColorManager.kPrimaryColor,
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorManager.kBlackLight,
        items: [
          for(int i=0;i<listIcon.length;i++)
            BottomNavigationBarItem(
                label:listIcon[i].text,
                icon: SvgPicture.asset(
                  listIcon[i].imageIconSvg,
                )),
        ]);
  }
}
