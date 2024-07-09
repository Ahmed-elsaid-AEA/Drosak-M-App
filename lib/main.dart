import 'package:drosak_m_app/app/my_app.dart';
import 'package:drosak_m_app/core/database/sqlite/education_stage_operation.dart';
import 'package:drosak_m_app/core/resources/routes_mananger.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String routeName = await checkWhichScreen();
  EducationStageOperation educationStageOperation = EducationStageOperation();
 bool inserted=await educationStageOperation.insertEducationDetails(
      ItemStageModel(id: 0, stageName: 'stageName', desc: 'desc', image: 'image'));
 print(inserted);
 runApp(MyApp(
    routesName: routeName,
  ));
}

Future<String> checkWhichScreen() async {
  String? androidVersion = await getAndroidVersion();
  if (androidVersion != null) {
    if (int.parse(androidVersion) >= 12) {
      // go to custom splash screen
      return RoutesName.kSplashScreenRoute;
    }
  }
  return RoutesName.kOnBoardingScreenRoute;
}

Future<String?> getAndroidVersion() async {
  if (Platform.isAndroid) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.release;
  }
  return null;
}
