import 'package:drosak_m_app/controller/education_stages/education_stages_controller.dart';
import 'package:drosak_m_app/view/education_stages/widgets/body/custom_list_view_items_stages.dart';
import 'package:flutter/material.dart';

import '../widgets/app_Bar/custom_app_bar_education_stages.dart';

class EducationStagesScreen extends StatefulWidget {
  const EducationStagesScreen({super.key});

  @override
  State<EducationStagesScreen> createState() => _EducationStagesScreenState();
}

class _EducationStagesScreenState extends State<EducationStagesScreen> {
  late EducationStagesController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = EducationStagesController();
  }

  @override
  void dispose() {
    _controller.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBarEductionStages(
              onPressedSearch: () {
                _controller.showCustomSearch(context);
              },
              onPressedAdd: () {
                _controller.openBottomSheet(context: context);
              },
            ),
            CustomListViewItemsStages(
              outPutDataListItemStageModel:
                  _controller.outPutDataListItemStageModel,
              editFun: (itemStageModel) {
                _controller.editItemStage(itemStageModel, context);
              },
              deleteFun: _controller.deleteItemStage,
            ),
          ],
        ),
      ),
    );
  }
}
