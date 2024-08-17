import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/model/explore_screen/explore_screen_model.dart';
import 'package:drosak_m_app/model/on_boarding/on_boarding_model.dart';

class ConstValue {
  static const double widthDesignScreen = 375;
  static const String kNext = 'التالي';
  static const String kSkip = 'تخطي';
  static const String kExploreApp = 'إستكشف التطبيق';
  static const double heightDesignScreen = 812;
  static const String kOnBoardingText1 = 'يمكنك إضافة  بعض المراحل التعليمية';
  static const String kOnBoardingText2 =
      'يمكنك إضافة  بعض المجموعات لكل مرحلة من المراحل التعليمية';
  static const String kOnBoardingText3 =
      'يمكنك إضافة  بعض الطلاب لكل جروب الموجودة في كل مرحلة تعليمية';
  static const String kOnBoardingText4 = 'يمكنك إضافة حضور وغياب لكل طالب';
  static const String kOnBoardingText5 =
      'يمكنك إضافة  ما إذا كان الطالب دفع هذا الشهر أم لا وإضافة تاريخ الدفع';
  static const String kEducationalStages = 'المراحل التعليمية';
  static const String kNameEducationalStages = 'اسم المرحله التعليميه';
  static const String kDescEducationalStage = 'وصف المرحله التعليميه';
  static const String kGroups = 'المجموعات';
  static const String kAddNewGroup = 'إضافه مجموعة جديده';
  static const String kEditThisGroup = 'تعديل تلك المجموعة';
  static const String kStudents = 'الطلاب';
  static const String kTheAudience = 'الحضور';
  static const String kPaying = 'الدفع';
  static const String kScreenIndex = 'currentIndex';
  static const String kAdd = 'إضافه';
  static const String kDelete = 'حذف';
  static const String kEdit = 'تعديل';
  static const String kContentSearch = 'محتوي البحث';
  static const String kChooseFrom = 'اختر من ...';
  static const String kAreYouSureToDeleteItem = 'هل أنت متاكد من حذف العنصر..؟';
  static const String kSure = 'متاكد';
  static const String kNo = 'لا';
  static const String kYes = 'نعم';
  static const String kCantEmpty = 'لا يمكن ان يكون الحقل فارغ';
}

class ConstListValues {
  static const List<OnBoardingModel> listOnBoardingModel = [
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
  static const List<ExploreScreenModel> listExploreScreenModel = [
    ExploreScreenModel(
        text: ConstValue.kEducationalStages,
        image: AssetsValuesManager.kOnBoardingImage1),
    ExploreScreenModel(
        text: ConstValue.kGroups, image: AssetsValuesManager.kOnBoardingImage2),
    ExploreScreenModel(
        text: ConstValue.kStudents,
        image: AssetsValuesManager.kOnBoardingImage3),
    ExploreScreenModel(
        text: ConstValue.kTheAudience,
        image: AssetsValuesManager.kOnBoardingImage4),
    ExploreScreenModel(
        text: ConstValue.kPaying, image: AssetsValuesManager.kOnBoardingImage5),
  ];
}
