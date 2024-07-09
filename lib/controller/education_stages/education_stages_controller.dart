import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:drosak_m_app/view/education_stages/widgets/body/custom_add_new_eudcation_stage.dart';
import 'package:flutter/material.dart';

class EducationStagesController {
  List<ItemStageModel> listItemStageModel = [];
  TextEditingController controllerNameEducationStage = TextEditingController();
  TextEditingController controllerDescEducationStage = TextEditingController();

  void openBottomSheet({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (context) => CustomAddNewEducationStage(
        controllerNameEducationStage: controllerNameEducationStage,
        controllerDescEducationStage: controllerDescEducationStage,
      ),
    );
  }

  void addToNewEducationalStageToDatabase() {}
}
