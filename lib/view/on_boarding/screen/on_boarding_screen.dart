import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/view/on_boarding/widgets/body/custom_item_on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/body/custom_page_view_on_boarding_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.green,
        height: 39,
      ),
      body: const SafeArea(
        child: CustomPageViewOnBoardingScreen(),
      ),
    );
  }
}

