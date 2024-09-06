import 'package:drosak_m_app/core/database/sqlite/my_sq_f_lite_databse.dart';

class AppointmentModel {
  String day;
  String time;
  String ms;
  int groupId;

  AppointmentModel(
      {required this.ms,
      required this.time,
      required this.day,
      this.groupId = 0});

  Map<String, dynamic> toJson() {
    return {
      MySqFLiteDatabase.appointmentsColumnDay: day,
      MySqFLiteDatabase.appointmentsColumnTime: time,
      MySqFLiteDatabase.appointmentsColumnMS: ms,
    };
  }
}
