import 'package:drosak_m_app/core/database/sqlite/my_sq_f_lite_databse.dart';
import 'package:drosak_m_app/model/groups/appointment_model.dart';

class StudentModel {
  final String name;
  final int id;
  final String image;
  final String note;
  final int idGroup;
  final String createdAt;
  final String? groupName;
  final String? educationName;
  final int? educationId;
  final List<AppointmentModel>? listAppointmentModel;

  @override
  String toString() {
    return 'StudentModel{name: $name, id: $id, image: $image, note: $note, idGroup: $idGroup, createdAt: $createdAt, groupName: $groupName, educationName: $educationName, listAppointmentModel: $listAppointmentModel}';
  }

  StudentModel(
      {required this.name,
      required this.id,
      required this.image,
      required this.createdAt,
      this.educationName,
      this.educationId,
      this.groupName,
      this.listAppointmentModel,
      required this.idGroup,
      required this.note});

  Map<String, dynamic> toJson() {
    return {
      MySqFLiteDatabase.studentsColumnName: name,
      MySqFLiteDatabase.studentsColumnNote: note,
      MySqFLiteDatabase.studentsColumnImage: image,
      MySqFLiteDatabase.studentsColumnIDGroups: idGroup,
    };
  }

//{id: 1,
// name: ahmed,
// image: /data/user/0/com.example.drosak_m_app/app_flutter/1000019996.jpg,
// note: tf,
// created_at: 2024-12-12 11:22:24,
// groups_id: 1,
// group_name: mq,
// education_stage_name: a11}
  factory StudentModel.fromJson(
      Map<String, dynamic> json, List<AppointmentModel> appointment) {
    //{student_name: vvg,
    // student_id: 1, student_image:
    // /data/user/0/com.example.drosak_m_app/app_flutter/1000019996.jpg
    // , student_note: , student_create_at: 2024-12-12 14:17:20,
    // student_group_id: 1, group_name: ddd, education_stage_name:
    // ah, id: 9, day: الأحد, time: 10 : 1, MS: ص, idGroups: 1}
    return StudentModel(
      name: json['student_name'],
      listAppointmentModel: appointment,
      id: json['student_id'],
      image: json['student_image'],
      educationId: json['education_stage_id'],
      createdAt: json['student_create_at'],
      idGroup: json['student_group_id'],
      note: json['student_note'],
      educationName: json['education_stage_name'],
      groupName: json['group_name'],
    );
  }
}
