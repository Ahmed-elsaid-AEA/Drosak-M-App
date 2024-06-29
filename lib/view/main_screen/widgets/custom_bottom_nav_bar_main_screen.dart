import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/resources/colors_manager.dart';
import '../../../model/main_screen/tabs_details_model.dart';

class CustomBottomNavBarMainScreen extends StatelessWidget {
  const CustomBottomNavBarMainScreen({
    super.key,
    required this.listIcon,
    required this.onTap,
  });

  final List<TabsDetailsModel> listIcon;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: onTap,
        currentIndex: 1,
        unselectedItemColor: ColorManager.kGreyLight,
        selectedItemColor: ColorManager.kPrimaryColor,
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorManager.kBlackLight,
        items: [
          for (int i = 0; i < listIcon.length; i++)
            BottomNavigationBarItem(
                label: listIcon[i].text,
                icon: SvgPicture.asset(
                  listIcon[i].imageIconSvg,
                )),
        ]);
  }
}
