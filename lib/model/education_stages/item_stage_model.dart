import 'package:drosak_m_app/core/database/sqlite/my_sq_f_lite_databse.dart';

class ItemStageModel {
  final int id;
  final String stageName;
  final String desc;
  final String image;
  String? createdAt;
  int status;

  @override
  String toString() {
    return 'ItemStageModel{id: $id, stageName: $stageName, desc: $desc, image: $image, createdAt: $createdAt, status: $status}';
  }

  Map<String, dynamic> toJson() {
    return {
      MySqFLiteDatabase.educationalStageName: stageName,
      MySqFLiteDatabase.educationalStageImage: image,
      MySqFLiteDatabase.educationalStageDesc: desc,
    };
  }

  ItemStageModel({
    required this.id,
    required this.stageName,
    required this.desc,
    required this.image,
    this.status = 1,
    this.createdAt,
  });

  factory ItemStageModel.fromJson(Map json) {
    return ItemStageModel(
        id: int.parse(json['id'].toString()),
        stageName: json['name'].toString(),
        desc: json['desc'].toString(),
        createdAt: json['created_at'].toString(),
        image: json['image'].toString(),
        status: json['status']);
  }
}
