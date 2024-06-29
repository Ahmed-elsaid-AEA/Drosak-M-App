import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,
          unselectedItemColor: ColorManager.kGreyLight,
          selectedItemColor: ColorManager.kPrimaryColor,
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorManager.kBlackLight,
          items: [
            BottomNavigationBarItem(
                label: "payment",
                icon: SvgPicture.asset(
                  AssetsValuesManager.kPaymentImageSvg,
                )),
            BottomNavigationBarItem(
                label: "ds",
                icon: SvgPicture.asset(AssetsValuesManager.kPaymentImageSvg)),
            BottomNavigationBarItem(
                label: "payment",
                icon: SvgPicture.asset(AssetsValuesManager.kPaymentImageSvg)),
            BottomNavigationBarItem(
                label: "ds",
                icon: SvgPicture.asset(AssetsValuesManager.kPaymentImageSvg)),
            BottomNavigationBarItem(
                label: "payment",
                icon: SvgPicture.asset(AssetsValuesManager.kPaymentImageSvg)),
          ]),
    );
  }
}
