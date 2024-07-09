import 'package:drosak_m_app/core/database/sqlite/my_sq_f_lite_databse.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';

class EducationStageOperation extends MySqFLiteDatabase {
  Future<bool> insertEducationDetails(ItemStageModel itemStageModel) {
    return insert(
        tableName: MySqFLiteDatabase.educationalStageTableName,
        values: {
          MySqFLiteDatabase.educationalStageName: itemStageModel.stageName,
          MySqFLiteDatabase.educationalStageImage: itemStageModel.image,
          MySqFLiteDatabase.educationalStageDesc: itemStageModel.desc,
        });
  }
}