import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/resources/colors_manager.dart';
import '../../../model/main_screen/tabs_details_model.dart';

class CustomBottomNavBarMainScreen extends StatelessWidget {
  const CustomBottomNavBarMainScreen({
    super.key,
    required this.listIcon,
    required this.onTap,
    required this.outPutBottomNavBar,
  });

  final List<TabsDetailsModel> listIcon;
  final ValueChanged<int> onTap;
  final Stream<int> outPutBottomNavBar;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: outPutBottomNavBar,
      builder: (context, snapshot) => BottomNavigationBar(
          onTap: onTap,
          currentIndex: snapshot.data == null ? 0 : snapshot.data!,
          unselectedItemColor: ColorManager.kGreyLight,
          selectedItemColor: ColorManager.kPrimaryColor,
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorManager.kBlackLight,
          items: [
            for (int i = 0; i < listIcon.length; i++)
              BottomNavigationBarItem(
                  label: listIcon[i].text,
                  icon: SvgPicture.asset(
                    colorFilter: ColorFilter.mode(
                        i != (snapshot.data ?? 0)
                            ? ColorManager.kGreyLight
                            : ColorManager.kPrimaryColor,
                        BlendMode.srcIn),
                    listIcon[i].imageIconSvg,
                  )),
          ]),
    );
  }
}
