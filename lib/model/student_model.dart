import 'package:drosak_m_app/core/database/sqlite/my_sq_f_lite_databse.dart';

class StudentModel {
  final String name;
  final int id;
  final String image;
  final String note;
  final int idGroup;
  final String createdAt;

  StudentModel({required this.name,
    required this.id,
    required this.image,
    required this.createdAt,
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

  factory StudentModel.fromJson(Map<String, dynamic> json){
    return StudentModel(name: json['name'],
        id: json['id'],
        image: json['image'],
        createdAt: json['created_at'],
        idGroup: json['groups_id'],
        note: json['note'],);
  }
}
