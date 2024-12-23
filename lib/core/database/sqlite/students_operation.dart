import 'package:drosak_m_app/core/database/sqlite/my_sq_f_lite_databse.dart';
import 'package:drosak_m_app/model/groups/appointment_model.dart';

import 'package:drosak_m_app/model/student_model.dart';

class StudentOperation extends MySqFLiteDatabase {
  Future<int> insertNewStudent(StudentModel studentModel) async {
    return insertReturnedId(
        tableName: MySqFLiteDatabase.studentsTableName,
        values: studentModel.toJson());
  }

  Future<List<StudentModel>> getStudentsInfo(
      {String? studentName, int? groupID}) async {
    List<StudentModel> listStudentModel = [];
    String query = "SELECT ${MySqFLiteDatabase.studentsTableName}.*,"
        "${MySqFLiteDatabase.groupTableName}.${MySqFLiteDatabase.groupColumnName}  as 'group_name',"
        "${MySqFLiteDatabase.educationalStageTableName}.${MySqFLiteDatabase.educationalStageName} as 'education_stage_name', "
        "${MySqFLiteDatabase.educationalStageTableName}.${MySqFLiteDatabase.educationalStageID} as 'education_stage_Id' "
        "FROM ${MySqFLiteDatabase.studentsTableName} INNER JOIN ${MySqFLiteDatabase.groupTableName} "
        "ON ${MySqFLiteDatabase.groupTableName}.${MySqFLiteDatabase.groupColumnID}=${MySqFLiteDatabase.studentsTableName}.${MySqFLiteDatabase.studentsColumnIDGroups} "
        "INNER JOIN ${MySqFLiteDatabase.educationalStageTableName} ON ${MySqFLiteDatabase.groupTableName}.${MySqFLiteDatabase.groupColumnIDEducation}=${MySqFLiteDatabase.educationalStageTableName}.${MySqFLiteDatabase.educationalStageID} ";
    if (studentName != null) {
      //?now in search model
      query +=
          " AND ${MySqFLiteDatabase.studentsTableName}.${MySqFLiteDatabase.studentsColumnName} LIke '%$studentName%'";
    } else if (groupID != null) {
      //?now in get student by  groupId
      query +=
          " AND ${MySqFLiteDatabase.studentsTableName}.${MySqFLiteDatabase.studentsColumnIDGroups} = $groupID ";
    }
    List<Map<String, Object?>> data = await selectUsingQuery(query: query);
    Map<String, List<AppointmentModel>> mapOfAppointment = {};
    //{
    // 1 : AppointmentModel{day: السبت, time: 15 : 5, ms: ص, groupId: 1, id: 1}

    // }
    for (int i = 0; i < data.length; i++) {
      String groupId = data[i]['groups_id'].toString();
      if (mapOfAppointment.containsKey(groupId)) {
      } else {
        StudentOperation studentOperation = StudentOperation();
        var listAppointment =
            await studentOperation._getListAppointment(groupId);
        mapOfAppointment[groupId] = listAppointment;
      }
    }
    listStudentModel += data
        .map(
          (item) => StudentModel.fromJson(
            item,
            mapOfAppointment[item['groups_id'].toString()]!,
          ),
        )
        .toList();

    return listStudentModel;
  }

  Future<List<AppointmentModel>> _getListAppointment(String groupId) async {
    List<AppointmentModel> listAppointmentModel = [];
    List<Map<String, Object?>> data = await search(
        tableName: MySqFLiteDatabase.appointmentsTableName,
        searchedId: groupId,
        columnID: MySqFLiteDatabase.appointmentsColumnIDGroups);
    listAppointmentModel +=
        data.map((item) => AppointmentModel.fromJson(item)).toList();
    return listAppointmentModel;
  }

  Future<bool> deleteStudent(int studentID) async {
    return delete(
        tableName: MySqFLiteDatabase.studentsTableName,
        where: ' ${MySqFLiteDatabase.studentsColumnID}==$studentID');
  }

  Future<bool> editStudentData(StudentModel studentModel) {
    return update(
        tableName: MySqFLiteDatabase.studentsTableName,
        values: studentModel.toJson(),
        where: ' ${MySqFLiteDatabase.studentsColumnID}==${studentModel.id}');
  }
}
