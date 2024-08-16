import 'dart:async';

import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/model/main_screen/tabs_details_model.dart';
import 'package:drosak_m_app/view/audience/screens/audience_screen.dart';
import 'package:drosak_m_app/view/education_stages/screens/education_stages_screen.dart';
import 'package:drosak_m_app/view/groups/screens/groups_screen.dart';
import 'package:drosak_m_app/view/paying/screens/paying_screen.dart';
import 'package:drosak_m_app/view/students/screens/students_screen.dart';
import 'package:flutter/cupertino.dart';

class MainScreenController {
  int currentIndexScreen = 0;
  late StreamController<int> controllerBody;
  late Sink<int> inputDataBody;
  late Stream<int> outputDataBody;

  /// bottom nav bar controllers
  late StreamController<int> controllerBottomNavBar;
  late Sink<int> inputDataBottomNavBar;
  late Stream<int> outPutBottomNavBar;

  ///
  MainScreenController() {
    initControllers();
  }

  void initControllers() {
    /// initialize body controller
    controllerBody = StreamController();
    inputDataBody = controllerBody.sink;
    outputDataBody = controllerBody.stream;
    //send current index
    inputDataBody.add(currentIndexScreen);

    /// initialize bottom nav bar controller
    controllerBottomNavBar = StreamController();
    inputDataBottomNavBar = controllerBottomNavBar.sink;
    outPutBottomNavBar = controllerBottomNavBar.stream;
    //send current index
    inputDataBottomNavBar.add(currentIndexScreen);
  }

  void disposeControllers() {
    ///dispose body controllers
    inputDataBody.close();
    controllerBody.close();

    ///dispose bottom nav var controllers
    inputDataBottomNavBar.close();
    controllerBottomNavBar.close();
  }

  void getArguments(BuildContext context) {
    Map arg = ModalRoute.of(context)!.settings.arguments as Map;
    currentIndexScreen = int.parse(arg[ConstValue.kScreenIndex].toString());
    inputDataBottomNavBar.add(currentIndexScreen);
    inputDataBody.add(currentIndexScreen);
  }

  List<TabsDetailsModel> listBottomNavBarTabModel = [
    const TabsDetailsModel(
        screen: EducationStagesScreen(),
        text: ConstValue.kEducationalStages,
        imageIconSvg: AssetsValuesManager.kEducationalStagesImageSvg),
    const TabsDetailsModel(
        screen: GroupsScreen(),
        text: ConstValue.kGroups,
        imageIconSvg: AssetsValuesManager.kGroupsImageSvg),
    const TabsDetailsModel(
        screen: StudentsScreen(),
        text: ConstValue.kStudents,
        imageIconSvg: AssetsValuesManager.kStudentsImageSvg),
    const TabsDetailsModel(
        screen: AudienceScreen(),
        text: ConstValue.kTheAudience,
        imageIconSvg: AssetsValuesManager.kTheAudienceImageSvg),
    const TabsDetailsModel(
        screen: PayingScreen(),
        text: ConstValue.kPaying,
        imageIconSvg: AssetsValuesManager.kPaymentImageSvg),
  ];

  void onTapAtTabItemBottomNavBar(int index) {
    currentIndexScreen = index;
    //send current index
    inputDataBody.add(currentIndexScreen);
    inputDataBottomNavBar.add(currentIndexScreen);
  }
}
