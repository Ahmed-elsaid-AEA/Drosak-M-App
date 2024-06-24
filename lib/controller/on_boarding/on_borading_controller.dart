import 'dart:async';

import 'package:drosak_m_app/core/resources/const_values.dart';
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
  void disposeController(){
    streamControllerDotIndicator.close();
    inputDotIndicator.close();
  }

  void goNext() {
    if (currentIndex + 1 >= ConstListValues.listOnBoardingImage.length) {
      currentIndex = 0;
    } else {
      currentIndex++;
    }
    inputDotIndicator.add(currentIndex);
  }

  void skip() {}
}
