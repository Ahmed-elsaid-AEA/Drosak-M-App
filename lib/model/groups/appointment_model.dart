import 'package:drosak_m_app/core/database/sqlite/my_sq_f_lite_databse.dart';

class AppointmentModel {
  String day;
  String time;
  String ms;
  int groupId;
  int id;

  AppointmentModel(
      {required this.ms,
      required this.time,
      required this.day,
      this.groupId = 0,
      this.id = 0});

  Map<String, dynamic> toJson(int groupID) {
    return {
      MySqFLiteDatabase.appointmentsColumnDay: day,
      MySqFLiteDatabase.appointmentsColumnTime: time,
      MySqFLiteDatabase.appointmentsColumnMS: ms,
      MySqFLiteDatabase.appointmentsColumnIDGroups: groupID,
    };
  }

  @override
  String toString() {
    return 'AppointmentModel{day: $day, time: $time, ms: $ms, groupId: $groupId, id: $id}';
  }

//   factory GroupDetails.fromJson(Map json) {
//     return GroupDetails(
//         id: int.parse(json['id'].toString()),
//         name: json['name'].toString(),
//         desc: json['note'].toString(),
//         educationStageID: int.tryParse(json['educationID'].toString()) ?? 0);
//   }
}
