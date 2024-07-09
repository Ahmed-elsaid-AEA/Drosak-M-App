class ItemStageModel {
  final int id;
  final String stageName;
  final String desc;
  final String image;

  @override
  String toString() {
    return 'ItemStageModel{id: $id, stageName: $stageName, desc: $desc, image: $image}';
  }

  const ItemStageModel({
    required this.id,
    required this.stageName,
    required this.desc,
    required this.image,
  });
   factory ItemStageModel.fromJson(Map json){
    return ItemStageModel(
        id: int.parse(json['id'].toString()),
        stageName: json['name'].toString(),
        desc: json['desc'].toString(),
        image: json['desc'].toString());
  }
}
