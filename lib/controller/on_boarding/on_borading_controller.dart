import 'dart:async';

import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/duration_values_manager.dart';
import 'package:drosak_m_app/core/resources/routes_mananger.dart';
import 'package:flutter/cupertino.dart';

class OnBoardingController {
  int currentIndex = 0;
  PageController pageControllerOnBoardingScreen =
      PageController(initialPage: 0);
  late StreamController<int> streamControllerDotIndicator;
  late Sink<int> inputDotIndicator;
  late Stream<int> outPutDotIndicator;

  OnBoardingController() {
    initController();
  }

  void initController() {
    streamControllerDotIndicator = StreamController();
    inputDotIndicator = streamControllerDotIndicator.sink;
    outPutDotIndicator = streamControllerDotIndicator.stream;
    inputDotIndicator.add(currentIndex);
  }

  void disposeController() {
    streamControllerDotIndicator.close();
    inputDotIndicator.close();
  }

  void goNext() {
    if (currentIndex + 1 >= ConstListValues.listOnBoardingModel.length) {
      currentIndex = 0;
    } else {
      currentIndex++;
    }
    pageControllerOnBoardingScreen.animateToPage(currentIndex,
        duration: const Duration(seconds: DurationValuesManager.s1), curve: Curves.easeInOut);
    inputDotIndicator.add(currentIndex);
  }

  void skip(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(RoutesName.kExploreAppScreenRoute, (route) => false);
  }
}
