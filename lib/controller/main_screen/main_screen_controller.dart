import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/model/main_screen/bottom_nav_bar_tab_model.dart';

class MainScreenController {
  List<BottomNavBarTabModel> listBottomNavBarTabModel = [
    const BottomNavBarTabModel(
        text: ConstValue.kPaying,
        imageIconSvg: AssetsValuesManager.kPaymentImageSvg),
    const BottomNavBarTabModel(
        text: ConstValue.kGroups,
        imageIconSvg: AssetsValuesManager.kGroupsImageSvg),
    const BottomNavBarTabModel(
        text: ConstValue.kStudents,
        imageIconSvg: AssetsValuesManager.kStudentsImageSvg),
    const BottomNavBarTabModel(
        text: ConstValue.kEducationalStages,
        imageIconSvg: AssetsValuesManager.kEducationalStagesImageSvg),
    const BottomNavBarTabModel(
        text: ConstValue.kTheAudience,
        imageIconSvg: AssetsValuesManager.kTheAudienceImageSvg),
  ];
}
