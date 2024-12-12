import 'package:drosak_m_app/core/database/sqlite/my_sq_f_lite_databse.dart';

class StudentModel {
  final String name;
  final int id;
  final String image;
  final String note;
  final int idGroup;
  final String createdAt;
  final String? groupName;
  final String? educationName;

  StudentModel(
      {required this.name,
      required this.id,
      required this.image,
      required this.createdAt,
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
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      name: json['name'],
      id: json['id'],
      image: json['image'],
      createdAt: json['created_at'],
      idGroup: json['groups_id'],
      note: json['note'],
      educationName: json['education_stage_name'],
      groupName: json['group_name'],
    );
  }
}
