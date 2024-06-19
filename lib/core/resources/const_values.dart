import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/model/on_boarding/on_boarding_model.dart';

class ConstValue {
  static const String kOnBoardingText1 = 'يمكنك إضافة  بعض المراحل التعليمية';
  static const String kOnBoardingText2 =
      'يمكنك إضافة  بعض المجموعات لكل مرحلة من المراحل التعليمية';
  static const String kOnBoardingText3 =
      'يمكنك إضافة  بعض الطلاب لكل جروب الموجودة في كل مرحلة تعليمية';
  static const String kOnBoardingText4 = 'يمكنك إضافة حضور وغياب لكل طالب';
  static const String kOnBoardingText5 =
      'يمكنك إضافة  ما إذا كان الطالب دفع هذا الشهر أم لا وإضافة تاريخ الدفع';
}

class ConstListValues {
  static const List<OnBoardingModel> listOnBoardingImage = [
    OnBoardingModel(
        text: ConstValue.kOnBoardingText1,
        image: AssetsValuesManager.kOnBoardingImage1),
    OnBoardingModel(
        text: ConstValue.kOnBoardingText2,
        image: AssetsValuesManager.kOnBoardingImage2),
    OnBoardingModel(
        text: ConstValue.kOnBoardingText3,
        image: AssetsValuesManager.kOnBoardingImage3),
    OnBoardingModel(
        text: ConstValue.kOnBoardingText4,
        image: AssetsValuesManager.kOnBoardingImage4),
    OnBoardingModel(
        text: ConstValue.kOnBoardingText5,
        image: AssetsValuesManager.kOnBoardingImage5),
  ];
}
