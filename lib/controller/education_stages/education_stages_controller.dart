import 'package:drosak_m_app/core/database/sqlite/education_stage_operation.dart';
import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:drosak_m_app/view/education_stages/widgets/body/custom_add_new_eudcation_stage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EducationStagesController {
  List<ItemStageModel> listItemStageModel = [];
  TextEditingController controllerNameEducationStage = TextEditingController();
  TextEditingController controllerDescEducationStage = TextEditingController();

  EducationStagesController() {
    init();
  }

  init() async {
    EducationStageOperation educationStageOperation = EducationStageOperation();
    var a = await educationStageOperation.getAllEducationData();
    print(a);
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) print(image.path);
// Capture a photo.
//   final XFile? photo = await picker.pickImage(source: ImageSource.camera);
  }

  void openBottomSheet({required BuildContext context}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => CustomAddNewEducationStage(
        onPressedPickImage: () {
          pickImage();
        },
        controllerNameEducationStage: controllerNameEducationStage,
        controllerDescEducationStage: controllerDescEducationStage,
        onPressedAdd: () {
          addNewEducation();
        },
      ),
    );
  }

  void addNewEducation() async {
    EducationStageOperation educationStageOperation = EducationStageOperation();
    bool inserted = await educationStageOperation.insertEducationDetails(
        ItemStageModel(
            id: 0,
            stageName: controllerNameEducationStage.text,
            desc: controllerDescEducationStage.text,
            image: AssetsValuesManager.kOnBoardingImage1));
    print(inserted);
  }
}
