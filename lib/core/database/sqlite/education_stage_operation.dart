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
    List<Map<String, Object?>> data = await select(
        tableName: MySqFLiteDatabase.educationalStageTableName,
        where: '${MySqFLiteDatabase.educationalStageStatus}==?',
        whereArgs: ['1']);
    listItemStageModel +=
        data.map((item) => ItemStageModel.fromJson(item)).toList();
    return listItemStageModel;
  }

  Future<bool> softDelete(ItemStageModel itemStageModel) async {
    return await update(
        tableName: MySqFLiteDatabase.educationalStageTableName,
        values: {
          MySqFLiteDatabase.educationalStageStatus: 0,
        },
        where:
            ' ${MySqFLiteDatabase.educationalStageID}==${itemStageModel.id}');
  }

  Future<bool> editEducationStage(ItemStageModel itemStageModel) async {
    print(itemStageModel.id);
    return await update(
        tableName: MySqFLiteDatabase.educationalStageTableName,
        values: {
          MySqFLiteDatabase.educationalStageName: itemStageModel.stageName
        },
        where: ' ${MySqFLiteDatabase.educationalStageID}=?',
        whereArgs: ['${itemStageModel.id}']);
  }

  Future<List<ItemStageModel>> getSearchWord(
      {required String searchWord}) async {
    List<ItemStageModel> listItemStageModel = [];
    List<Map<String, Object?>> data = await searchUsingLike(
        columnName: MySqFLiteDatabase.educationalStageName,
        tableName: MySqFLiteDatabase.educationalStageTableName,
        searchWord: searchWord);
    listItemStageModel +=
        data.map((item) => ItemStageModel.fromJson(item)).toList();

    return listItemStageModel;
  }
}
