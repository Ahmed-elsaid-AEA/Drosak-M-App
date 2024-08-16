import 'package:drosak_m_app/controller/main_screen/main_screen_controller.dart';
import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/model/main_screen/tabs_details_model.dart';
import 'package:drosak_m_app/view/main_screen/widgets/custom_bottom_nav_bar_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late MainScreenController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = MainScreenController();
  }

  @override
  void dispose() {
    _controller.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.getArguments(context);
    return Scaffold(
      body: StreamBuilder<int>(
        stream: _controller.outputDataBody,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _controller.listBottomNavBarTabModel[snapshot.data!].screen,
      ),
      backgroundColor: Colors.red,
      bottomNavigationBar: CustomBottomNavBarMainScreen(
        outPutBottomNavBar: _controller.outPutBottomNavBar,
        onTap: (value) {
          _controller.onTapAtTabItemBottomNavBar(value);
        },
        listIcon: _controller.listBottomNavBarTabModel,
      ),
    );
  }
}
