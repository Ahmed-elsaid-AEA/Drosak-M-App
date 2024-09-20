import 'package:drosak_m_app/core/database/sqlite/my_sq_f_lite_databse.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:drosak_m_app/model/groups/group_details.dart';
import 'package:drosak_m_app/model/groups/appointment_model.dart';
import 'package:drosak_m_app/model/groups/groups_info_model.dart';

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

  Future<List<GroupDetails>> _getAllGroupsData() async {
    List<GroupDetails> listGroupsDetails = [];
    List<Map<String, Object?>> data =
        await select(tableName: MySqFLiteDatabase.groupTableName);
    listGroupsDetails +=
        data.map((item) => GroupDetails.fromJson(item)).toList();
    return listGroupsDetails;
  }

  Future<List<AppointmentModel>> _getAllAppointmentData() async {
    List<AppointmentModel> listAppointment = [];
    List<Map<String, Object?>> data =
        await select(tableName: MySqFLiteDatabase.appointmentsTableName);
    listAppointment +=
        data.map((item) => AppointmentModel.fromJson(item)).toList();
    return listAppointment;
  }

  Future<List<GroupInfoModel>> getAllGroupsInfo() async {
    List<GroupInfoModel> listGroupInfo = [];
    List<GroupDetails> listGroupDetails = await _getAllGroupsData();
    GroupsOperation groupsOperation = GroupsOperation();
    List<AppointmentModel> listAppointmentModel =
        await groupsOperation._getAllAppointmentData();

    for (var item in listGroupDetails) {
      List<AppointmentModel> listAppointment = listAppointmentModel
          .where((element) => element.groupId == item.id)
          .toList();
      listGroupInfo.add(
          GroupInfoModel(groupDetails: item, listAppointment: listAppointment));
    }

    return listGroupInfo;
  }

  Future<bool> startDelete(GroupInfoModel groupInfoModel) async {
    return await delete(
        tableName: MySqFLiteDatabase.groupTableName,
        where:
            ' ${MySqFLiteDatabase.groupColumnID}==${groupInfoModel.groupDetails.id}');
  }

  Future<bool> editEducationStage(GroupInfoModel groupInfoModel) async {
    bool done = false;
    //?update appointment
    done = await _updateGroupTable(groupInfoModel.groupDetails);
    // if(done==true)
    //   done=_updateAppointment(appin, groupId)
    //?update GroupTable
    print(done);
    return done;
  }

  Future<bool> _updateGroupTable(GroupDetails groupDetails) async {
    print(groupDetails.id);
    return await update(
        tableName: MySqFLiteDatabase.groupTableName,
        values: groupDetails.toJson(),
        where: ' ${MySqFLiteDatabase.groupColumnID}=?',
        whereArgs: ['${groupDetails.id}']);
  }

  Future<bool> _updateAppointment(
      AppointmentModel appointmentModel, int groupId) async {
    return await update(
        tableName: MySqFLiteDatabase.appointmentsTableName,
        values: appointmentModel.toJson(groupId),
        where: ' ${MySqFLiteDatabase.appointmentsColumnID}=?',
        whereArgs: ['${appointmentModel.id}']);
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
