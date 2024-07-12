import 'package:drosak_m_app/core/database/sqlite/my_sq_f_lite_databse.dart';

class ItemStageModel {
  final int id;
  final String stageName;
  final String desc;
  final String image;

  @override
  String toString() {
    return 'ItemStageModel{id: $id, stageName: $stageName, desc: $desc, image: $image}';
  }


  Map<String, dynamic> toJson() {
    return {
      MySqFLiteDatabase.educationalStageName: stageName,
      MySqFLiteDatabase.educationalStageImage: image,
      MySqFLiteDatabase.educationalStageDesc: desc,
    };
  }

  const ItemStageModel({
    required this.id,
    required this.stageName,
    required this.desc,
    required this.image,
  });

  factory ItemStageModel.fromJson(Map json) {
    return ItemStageModel(
        id: int.parse(json['id'].toString()),
        stageName: json['name'].toString(),
        desc: json['desc'].toString(),
        image: json['image'].toString());
  }
}
