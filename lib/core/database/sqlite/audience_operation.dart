import 'package:drosak_m_app/core/database/sqlite/my_sq_f_lite_databse.dart';
import 'package:drosak_m_app/core/database/sqlite/students_operation.dart';
import 'package:drosak_m_app/model/student_model.dart';

class AudienceOperation extends MySqFLiteDatabase {
  Future<List<StudentModel>> getStudentInfoByGroupID(int groupId) async {
    StudentOperation studentOperation = StudentOperation();
    return await studentOperation.getStudentsInfo(groupID: groupId);
  }
  // Future<int> insertNewAudience(GroupDetails groupDetails) async {
  //   return insertReturnedId(
  //       tableName: MySqFLiteDatabase.groupTableName,
  //       values: groupDetails.toJson());
  // }
}
