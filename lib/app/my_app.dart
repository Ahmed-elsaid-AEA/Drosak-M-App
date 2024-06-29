import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/routes_mananger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.routesName});

  final String routesName;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
          ConstValue.widthDesignScreen, ConstValue.heightDesignScreen),
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: ColorManager.kBlackColor
        ),
        routes: RoutesManager.routes,
        initialRoute:routesName,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
