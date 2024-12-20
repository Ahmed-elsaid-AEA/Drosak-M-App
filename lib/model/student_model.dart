import 'package:drosak_m_app/core/database/sqlite/my_sq_f_lite_databse.dart';
import 'package:drosak_m_app/model/groups/appointment_model.dart';

class StudentModel {
  final String name;
  final int? id;
  final String image;
  final String note;
  final int idGroup;
  final int? idEducationStage;
  final String? createdAt;
  final String? groupName;
  final String? educationName;
  final List<AppointmentModel>? listAppointmentModel;

  @override
  String toString() {
    return 'StudentModel{name: $name, id: $id, image: $image, note: $note, idGroup: $idGroup, createdAt: $createdAt, groupName: $groupName, educationName: $educationName, listAppointmentModel: $listAppointmentModel}';
  }

  StudentModel(
      {required this.name,
      this.id,
      required this.image,
      this.createdAt,
      this.listAppointmentModel,
      this.idEducationStage,
      this.educationName,
      this.groupName,
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
      Map<String, dynamic> json, List<AppointmentModel> listAppointmentModel) {
    return StudentModel(
      name: json['name'],
      id: json['id'],
      image: json['image'],
      createdAt: json['created_at'],
      idGroup: json['groups_id'],
      note: json['note'],
      educationName: json['education_stage_name'],
      groupName: json['group_name'],
      idEducationStage: json['education_stage_Id'],
      listAppointmentModel: listAppointmentModel,
    );
  }
}
