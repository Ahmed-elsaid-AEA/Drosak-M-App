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
      MySqFLiteDatabase.groupColumnIDEducation: educationStageID,
    };
  }

  // {id: 1, name: h BB, note: , educationID: }
  factory GroupDetails.fromJson(Map json) {
    return GroupDetails(
        id: int.parse(json['id'].toString()),
        name: json['name'].toString(),
        desc: json['note'].toString(),
        educationStageID: int.tryParse(json['educationID'].toString()) ?? 0);
  }

  @override
  String toString() {
    return 'GroupDetails{id: $id, name: $name, desc: $desc, educationStageID: $educationStageID}';
  }
}
