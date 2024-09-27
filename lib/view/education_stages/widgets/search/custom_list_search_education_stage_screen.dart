import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/height_manager.dart';
import 'package:drosak_m_app/core/widgets/space/vertical_space.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:drosak_m_app/view/education_stages/widgets/body/custom_item_stage.dart';
import 'package:flutter/cupertino.dart';

class CustomListSearchEducationStageScreen extends StatelessWidget {
  const CustomListSearchEducationStageScreen(
      {super.key,
      required this.getSearchItemStage,
      required this.deleteFun,
      required this.editFun});

  final Future<List<ItemStageModel>> getSearchItemStage;
  final void Function(ItemStageModel itemStageModel) deleteFun;
  final void Function(ItemStageModel itemStageModel) editFun;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ItemStageModel>>(
        future: getSearchItemStage,
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CupertinoActivityIndicator(
                  color: ColorManager.kPrimaryColor,
                ))
              : Directionality(
            textDirection: TextDirection.rtl,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      VerticalSpace(HeightManager.h24),
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) =>
                                index == snapshot.data!.length
                                    ? VerticalSpace(HeightManager.h24)
                                    : CustomItemStage(
                                        itemStageModel: snapshot.data![index],
                                        editFun: editFun,
                                        deleteFun: deleteFun,
                                      ),
                            separatorBuilder: (context, index) =>
                                VerticalSpace(HeightManager.h24),
                            itemCount: snapshot.data!.length + 1),
                      ),
                    ],
                  ),
              );
        });
  }
}
