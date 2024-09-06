import 'dart:developer';

import 'package:drosak_m_app/core/database/sqlite/my_sq_f_lite_databse.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:drosak_m_app/model/groups/group_details.dart';
import 'package:drosak_m_app/model/groups/appointment_model.dart';

class GroupsOperation extends MySqFLiteDatabase {
  Future<int> insertGroupDetails(GroupDetails groupDetails) async {
    return insertReturnedId(
        tableName: MySqFLiteDatabase.groupTableName,
        values: groupDetails.toJson());
  }

  Future<bool> insertAppointmentDetails(
      AppointmentModel appointment, int groupID) {
    return insert(
        tableName: MySqFLiteDatabase.appointmentsTableName,
        values: appointment.toJson(groupID));
  }

  Future<List<GroupDetails>> getAllGroupsData() async {
    List<GroupDetails> listGroupsDetails = [];
    List<Map<String, Object?>> data =
        await select(tableName: MySqFLiteDatabase.groupTableName);
    listGroupsDetails +=
        data.map((item) => GroupDetails.fromJson(item)).toList();
    return listGroupsDetails;
  }

  Future<List<AppointmentModel>> getAllAppointmentData() async {
    List<AppointmentModel> listAppointment = [];
    List<Map<String, Object?>> data =
        await select(tableName: MySqFLiteDatabase.appointmentsTableName);
    // listAppointment +=
    //     data.map((item) => AppointmentModel.fromJson(item)).toList();
    log(data.toString());
    return listAppointment;
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
    List<Map<String, Object?>> data = await search(
        tableName: MySqFLiteDatabase.educationalStageTableName,
        searchWord: searchWord);
    listItemStageModel +=
        data.map((item) => ItemStageModel.fromJson(item)).toList();

    return listItemStageModel;
  }
}
