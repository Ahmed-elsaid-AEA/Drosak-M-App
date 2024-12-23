import 'package:drosak_m_app/core/database/sqlite/my_sq_f_lite_databse.dart';
import 'package:drosak_m_app/core/database/sqlite/students_operation.dart';
import 'package:drosak_m_app/model/audience/audience_model.dart';
import 'package:drosak_m_app/model/student_model.dart';

class AudienceOperation extends MySqFLiteDatabase {
  Future<List<StudentModel>> getStudentInfoByGroupID(int groupId) async {
    StudentOperation studentOperation = StudentOperation();
    return await studentOperation.getStudentsInfo(groupID: groupId);
  }
  Future<int> insertNewAudience(AudienceModel audienceModel) async {
    return insertReturnedId(
        tableName: MySqFLiteDatabase.audienceTableName,
        values: audienceModel.toJson());
  }
}
