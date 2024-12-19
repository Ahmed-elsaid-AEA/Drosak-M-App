import 'dart:developer';

import 'package:drosak_m_app/core/database/sqlite/my_sq_f_lite_databse.dart';
import 'package:drosak_m_app/model/groups/appointment_model.dart';

import 'package:drosak_m_app/model/student_model.dart';

class StudentOperation extends MySqFLiteDatabase {
  Future<int> insertNewStudent(StudentModel studentModel) async {
    return insertReturnedId(
        tableName: MySqFLiteDatabase.studentsTableName,
        values: studentModel.toJson());
  }

  Future<List<StudentModel>> getStudentsInfo() async {
    List<StudentModel> listStudentModel = [];
    List<Map<String, Object?>> data = await selectUsingQuery(
        query:
            "SELECT ${MySqFLiteDatabase.studentsTableName}.${MySqFLiteDatabase.studentsColumnName} as 'student_name',${MySqFLiteDatabase.studentsTableName}.${MySqFLiteDatabase.studentsColumnID} as 'student_id',${MySqFLiteDatabase.studentsTableName}.${MySqFLiteDatabase.studentsColumnImage} as 'student_image',${MySqFLiteDatabase.studentsTableName}.${MySqFLiteDatabase.studentsColumnNote} as 'student_note',${MySqFLiteDatabase.studentsTableName}.${MySqFLiteDatabase.studentsColumnCreatedAt} as 'student_create_at',${MySqFLiteDatabase.studentsTableName}.${MySqFLiteDatabase.studentsColumnIDGroups} as 'student_group_id',${MySqFLiteDatabase.groupTableName}.${MySqFLiteDatabase.groupColumnName}  as 'group_name',${MySqFLiteDatabase.educationalStageTableName}.${MySqFLiteDatabase.educationalStageName} as 'education_stage_name' , ${MySqFLiteDatabase.appointmentsTableName}.* FROM ${MySqFLiteDatabase.studentsTableName} INNER JOIN ${MySqFLiteDatabase.groupTableName} ON ${MySqFLiteDatabase.groupTableName}.${MySqFLiteDatabase.groupColumnID}=${MySqFLiteDatabase.studentsTableName}.${MySqFLiteDatabase.studentsColumnIDGroups} INNER JOIN ${MySqFLiteDatabase.educationalStageTableName} ON ${MySqFLiteDatabase.groupTableName}.${MySqFLiteDatabase.groupColumnIDEducation}=${MySqFLiteDatabase.educationalStageTableName}.${MySqFLiteDatabase.educationalStageID} INNER JOIN ${MySqFLiteDatabase.appointmentsTableName} ON ${MySqFLiteDatabase.appointmentsTableName}.${MySqFLiteDatabase.appointmentsColumnIDGroups}=${MySqFLiteDatabase.groupTableName}.${MySqFLiteDatabase.groupColumnID}");

     listStudentModel +=
        data.map((item) => StudentModel.fromJson(item)).toList();

    return listStudentModel;
  }
}
