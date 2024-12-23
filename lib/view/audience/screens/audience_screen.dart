import 'package:drosak_m_app/controller/audience/audience_controller.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/widgets/app_bar/custom_app_bar_title_add_search.dart';
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
            // CustomListViewItemsStudents(
            //   outPutDataListItemStudentModel:
            //       _controller.outPutDataListItemStudentModel,
            //   deleteFun: _controller.onTapDelete,
            //   editFun: _controller.onTapEdit,
            //   onRefresh: () {
            //     _controller.onTapRefresh();
            //   },
            // ),
            // CustomItemStudent(
            //   groupInfoModel: GroupInfoModel(
            //       groupDetails: GroupDetails(
            //           desc: "desc", name: "name", educationStageID: 1),
            //       listAppointment: [
            //         AppointmentModel(ms: "ms", time: "time", day: "day")
            //       ]),
            //   deleteFun: (itemStageModel) {},
            //   editFun: (itemStageModel) {},
            // )
          ],
        ),
      ),
    );
  }
}
