import 'package:drosak_m_app/controller/audience/audience_controller.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/widgets/app_bar/custom_app_bar_title_add_search.dart';
import 'package:drosak_m_app/view/audience/widgets/custom_select_education_stage_name_audience_screen.dart';
import 'package:drosak_m_app/view/audience/widgets/custom_select_group_name_audiencet_screen.dart';
import 'package:flutter/material.dart';

class AudienceScreen extends StatefulWidget {
  const AudienceScreen({super.key});

  @override
  State<AudienceScreen> createState() => _AudienceScreenState();
}

class _AudienceScreenState extends State<AudienceScreen> {
  late AudienceController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AudienceController(context);
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
            CustomAppBarTitleAddSearch(
              title: ConstValue.kTheAudience,
              onPressedSearch: () {
                // _controller.onPressedSearch();
              },
              onPressedAdd: () {},
            ),
            CustomSelectEducationStageNameAudienceScreen(
                outPutDataListItemStageModel:
                    _controller.outPutDataListItemStageModel,
                onChanged: _controller.onChangedSelectEducationStageName,
                outPutDataInitialItem:
                    _controller.outPutDataInitialItemSelectedStage),
            CustomSelectGroupNameAudienceScreen(
                outPutDataListItemGroupsDetails:
                    _controller.outPutDataListItemGroupsDetails,
                onChanged: _controller.onChangedSelectGroupsName,
                outPutDataInitialSelectedGroup:
                    _controller.outPutDataInitialItemSelectedGroup)
          ],
        ),
      ),
    );
  }
}
