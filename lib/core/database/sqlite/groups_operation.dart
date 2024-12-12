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
    List<Map<String, Object?>> data = await selectUsingQuery(
        query:
            'SELECT ${MySqFLiteDatabase.groupTableName}.* FROM ${MySqFLiteDatabase.groupTableName},${MySqFLiteDatabase.educationalStageTableName} WHERE ${MySqFLiteDatabase.educationalStageTableName}.${MySqFLiteDatabase.educationalStageStatus} = 1 AND ${MySqFLiteDatabase.educationalStageTableName}.${MySqFLiteDatabase.educationalStageID}==${MySqFLiteDatabase.groupTableName}.${MySqFLiteDatabase.groupColumnIDEducation};');

    listGroupsDetails +=
        data.map((item) => GroupDetails.fromJson(item)).toList();
    return listGroupsDetails;
  }

  Future<List<GroupDetails>> _getSearchedGroupsName(String groupName) async {
    List<GroupDetails> listGroupsDetails = [];
    List<Map<String, Object?>> data = await searchUsingLike(
        columnName: MySqFLiteDatabase.groupColumnName,
        tableName: MySqFLiteDatabase.groupTableName,
        searchWord: groupName);
    listGroupsDetails +=
        data.map((item) => GroupDetails.fromJson(item)).toList();
    return listGroupsDetails;
  }

  Future<List<AppointmentModel>> _getSearchedGroupsAppointments(
      String groupId) async {
    List<AppointmentModel> listAppointmentModel = [];
    List<Map<String, Object?>> data = await search(
        columnID: MySqFLiteDatabase.appointmentsColumnIDGroups,
        tableName: MySqFLiteDatabase.appointmentsTableName,
        searchedId: groupId);
    listAppointmentModel +=
        data.map((item) => AppointmentModel.fromJson(item)).toList();
    return listAppointmentModel;
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

  Future<bool> _deleteAppointment(AppointmentModel appointmentModel) async {
    return await delete(
        tableName: MySqFLiteDatabase.appointmentsTableName,
        where:
            ' ${MySqFLiteDatabase.appointmentsColumnID}==${appointmentModel.id}');
  }

  Future<bool> editEducationStage(GroupInfoModel groupInfoModel,
      List<AppointmentModel> oldAppointmentModel) async {
    bool updateGroup = false;
    bool deleteAppointment = false;
    bool insertAppointment = false;
    //?update appointment
    updateGroup = await _updateGroupTable(groupInfoModel.groupDetails);
    if (updateGroup == true) {
      //?delete all Appointment
      for (var item in oldAppointmentModel) {
        GroupsOperation groupsOperation = GroupsOperation();
        deleteAppointment = await groupsOperation._deleteAppointment(item);
        if (deleteAppointment == false) {
          break;
        }
      }
      if (deleteAppointment == true) {
        //? insert new
        for (var item in groupInfoModel.listAppointment) {
          GroupsOperation groupsOperation = GroupsOperation();
          insertAppointment = await groupsOperation.insertAppointmentDetails(
              item, groupInfoModel.groupDetails.id);
          if (insertAppointment == false) {
            break;
          }
        }
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
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

  Future<List<GroupInfoModel>> getSearchWord(
      {required String groupName}) async {
    List<GroupInfoModel> listGroupInfo = [];
    //? get all search group details
    List<GroupDetails> listGroupDetails =
        await _getSearchedGroupsName(groupName);
    // print(listGroupDetails);
    List<AppointmentModel> listAppointmentModel = [];

    ///? get all appointment that have this groups id
    for (var groupDetails in listGroupDetails) {
      GroupsOperation groupsOperation = GroupsOperation();
      listAppointmentModel += await groupsOperation
          ._getSearchedGroupsAppointments(groupDetails.id.toString());
    }
    //? make filtering
    for (var item in listGroupDetails) {
      List<AppointmentModel> listAppointment = listAppointmentModel
          .where((element) => element.groupId == item.id)
          .toList();
      listGroupInfo.add(
          GroupInfoModel(groupDetails: item, listAppointment: listAppointment));
    }

    return listGroupInfo;
  }

  Future<List<GroupDetails>> getGroupInnerJoinEducationStage(
      {required int educationID}) async {
    List<GroupDetails> listGroupsDetails = [];
    List<Map<String, Object?>> data = await selectUsingQuery(
        query:
            "SELECT ${MySqFLiteDatabase.groupTableName}.* FROM ${MySqFLiteDatabase.groupTableName} INNER JOIN ${MySqFLiteDatabase.educationalStageTableName} ON ${MySqFLiteDatabase.groupTableName}.${MySqFLiteDatabase.groupColumnIDEducation}=${MySqFLiteDatabase.educationalStageTableName}.${MySqFLiteDatabase.educationalStageID} AND  ${MySqFLiteDatabase.groupTableName}.${MySqFLiteDatabase.groupColumnIDEducation}=$educationID");
    listGroupsDetails +=
        data.map((item) => GroupDetails.fromJson(item)).toList();
    return listGroupsDetails;
  }
  Future<List<AppointmentModel>> getAppointmentsGroupInnerJoinGroupsTable(
      {required int groupId}) async {
    List<AppointmentModel> listAppointmentModel = [];
    List<Map<String, Object?>> data = await selectUsingQuery(
        query:
            "SELECT ${MySqFLiteDatabase.appointmentsTableName}.* FROM ${MySqFLiteDatabase.appointmentsTableName} INNER JOIN ${MySqFLiteDatabase.groupTableName} ON ${MySqFLiteDatabase.groupTableName}.${MySqFLiteDatabase.groupColumnID}=${MySqFLiteDatabase.appointmentsTableName}.${MySqFLiteDatabase.appointmentsColumnIDGroups} AND  ${MySqFLiteDatabase.appointmentsTableName}.${MySqFLiteDatabase.appointmentsColumnIDGroups}=$groupId");
    listAppointmentModel +=
        data.map((item) => AppointmentModel.fromJson(item)).toList();
    return listAppointmentModel;
  }
}
