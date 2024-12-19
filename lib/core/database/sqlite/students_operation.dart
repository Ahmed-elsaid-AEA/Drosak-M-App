import 'package:drosak_m_app/core/database/sqlite/my_sq_f_lite_databse.dart';
import 'package:drosak_m_app/model/groups/appointment_model.dart';

import 'package:drosak_m_app/model/student_model.dart';

class StudentOperation extends MySqFLiteDatabase {
  Future<int> insertNewStudent(StudentModel studentModel) async {
    return insertReturnedId(
        tableName: MySqFLiteDatabase.studentsTableName,
        values: studentModel.toJson());
  }

  Future<bool> updateStudent(StudentModel studentModel) async {
    bool updated = await update(
        tableName: MySqFLiteDatabase.studentsTableName,
        values: studentModel.toJson(),
        where: ' ${MySqFLiteDatabase.studentsColumnID}=?',
        whereArgs: ['${studentModel.id}']);
    return updated;
  }

  Future<List<StudentModel>> getStudentsInfo({int? studentId}) async {
    List<StudentModel> listStudentModel = [];

    String qurey =
        "SELECT ${MySqFLiteDatabase.studentsTableName}.${MySqFLiteDatabase.studentsColumnName} "
        "as 'student_name',${MySqFLiteDatabase.studentsTableName}.${MySqFLiteDatabase.studentsColumnID} "
        "as 'student_id',${MySqFLiteDatabase.studentsTableName}.${MySqFLiteDatabase.studentsColumnImage}"
        " as 'student_image',${MySqFLiteDatabase.studentsTableName}.${MySqFLiteDatabase.studentsColumnNote} "
        "as 'student_note',${MySqFLiteDatabase.studentsTableName}.${MySqFLiteDatabase.studentsColumnCreatedAt} "
        "as 'student_create_at',${MySqFLiteDatabase.studentsTableName}.${MySqFLiteDatabase.studentsColumnIDGroups}"
        " as 'student_group_id',${MySqFLiteDatabase.groupTableName}.${MySqFLiteDatabase.groupColumnName} "
        " as 'group_name',"
        "${MySqFLiteDatabase.educationalStageTableName}.${MySqFLiteDatabase.educationalStageName}"
        " as 'education_stage_name' ,"
        "${MySqFLiteDatabase.educationalStageTableName}.${MySqFLiteDatabase.educationalStageID}"
        " as 'education_stage_id' ,"
        ""
        " ${MySqFLiteDatabase.appointmentsTableName}.* FROM ${MySqFLiteDatabase.studentsTableName} INNER JOIN ${MySqFLiteDatabase.groupTableName} ON ${MySqFLiteDatabase.groupTableName}.${MySqFLiteDatabase.groupColumnID}=${MySqFLiteDatabase.studentsTableName}.${MySqFLiteDatabase.studentsColumnIDGroups} INNER JOIN ${MySqFLiteDatabase.educationalStageTableName} ON ${MySqFLiteDatabase.groupTableName}.${MySqFLiteDatabase.groupColumnIDEducation}=${MySqFLiteDatabase.educationalStageTableName}.${MySqFLiteDatabase.educationalStageID} INNER JOIN ${MySqFLiteDatabase.appointmentsTableName} ON ${MySqFLiteDatabase.appointmentsTableName}.${MySqFLiteDatabase.appointmentsColumnIDGroups}=${MySqFLiteDatabase.groupTableName}.${MySqFLiteDatabase.groupColumnID}";
    if (studentId != null) {
      qurey +=
          " AND ${MySqFLiteDatabase.studentsTableName}.${MySqFLiteDatabase.studentsColumnID} = $studentId";
    }
    List<Map<String, Object?>> data = await selectUsingQuery(query: qurey);
    Map<String, List<AppointmentModel>> mapOfListAppointment = {};
    //{
    // "1" : [AppointmentModel{day: السبت, time: 10 : 1, ms: ص, groupId: 1, id: 1}],
    // "2" : [AppointmentModel{day: السبت, time: 10 : 1, ms: ص, groupId: 1, id: 1}],
    // }
    for (int index = 0; index < data.length; index++) {
      String groupId = data[index]['student_group_id'].toString();
      if (mapOfListAppointment.containsKey(groupId)) {
      } else {
        StudentOperation studentOperation = StudentOperation();
        List<AppointmentModel> listAppointmentModel =
            await studentOperation._getGroupAppointment(groupId);
        mapOfListAppointment[groupId] = listAppointmentModel;
      }
    }

    listStudentModel += data
        .map((item) => StudentModel.fromJson(
            item, mapOfListAppointment[item['student_group_id'].toString()]!))
        .toList();
    return listStudentModel;
  }

  Future<List<AppointmentModel>> _getGroupAppointment(String groupId) async {
    List<AppointmentModel> listAppointmentModel = [];
    List<Map<String, Object?>> data = await search(
        tableName: MySqFLiteDatabase.appointmentsTableName,
        columnID: MySqFLiteDatabase.appointmentsColumnIDGroups,
        searchedId: groupId);
    listAppointmentModel +=
        data.map((item) => AppointmentModel.fromJson(item)).toList();

    return listAppointmentModel;
  }

  Future<bool> deleteStudent(int id) => delete(
        tableName: MySqFLiteDatabase.studentsTableName,
        where: ' ${MySqFLiteDatabase.studentsColumnID}==$id',
      );
}
