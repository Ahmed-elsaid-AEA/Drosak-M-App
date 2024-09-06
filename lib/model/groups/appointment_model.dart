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

  factory AppointmentModel.fromJson(Map json) {
    return AppointmentModel(ms: json['MS'],
        id: int.parse(json['id'].toString()),
        day: json['day'].toString(),
        time: json['time'].toString(),
        groupId: int.tryParse(json['idGroups'].toString()) ?? 0);
  }
}
