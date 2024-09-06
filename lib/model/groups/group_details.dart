import 'package:drosak_m_app/core/database/sqlite/my_sq_f_lite_databse.dart';

class GroupDetails {
  int id;
  String name;
  String desc;
  int educationStageID;

  GroupDetails(
      {required this.desc,
      required this.name,
      this.id = 0,
      required this.educationStageID});

  Map<String, dynamic> toJson() {
    return {
      MySqFLiteDatabase.groupColumnName: name,
      MySqFLiteDatabase.groupColumnNote: desc,
      MySqFLiteDatabase.groupColumnIDEducation: desc,
    };
  }
  // factory ItemStageModel.fromJson(Map json) {
  //   return ItemStageModel(
  //       id: int.parse(json['id'].toString()),
  //       stageName: json['name'].toString(),
  //       desc: json['desc'].toString(),
  //       createdAt: json['created_at'].toString(),
  //       image: json['image'].toString(),
  //       status: json['status']);
  // }
}
