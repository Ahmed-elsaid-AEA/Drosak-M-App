import 'package:drosak_m_app/core/database/sqlite/my_sq_f_lite_databse.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';

class EducationStageOperation extends MySqFLiteDatabase {
  Future<bool> insertEducationDetails(ItemStageModel itemStageModel) {
    return insert(
        tableName: MySqFLiteDatabase.educationalStageTableName,
        values: itemStageModel.toJson());
  }

  Future<List<ItemStageModel>> getAllEducationData() async {
    List<ItemStageModel> listItemStageModel = [];
    List<Map<String, Object?>> data =
        await select(tableName: MySqFLiteDatabase.educationalStageTableName);
    listItemStageModel +=
        data.map((item) => ItemStageModel.fromJson(item)).toList();
    print(listItemStageModel);
    return listItemStageModel;
  }

  Future<List<ItemStageModel>> getSearchWord(
      {required String searchWord}) async {
    List<ItemStageModel> listItemStageModel = [];
    List<Map<String, Object?>> data = await search(
        tableName: MySqFLiteDatabase.educationalStageTableName,
        searchWord: searchWord);
    listItemStageModel +=
        data.map((item) => ItemStageModel.fromJson(item)).toList();
 
    return listItemStageModel;
  }
}
