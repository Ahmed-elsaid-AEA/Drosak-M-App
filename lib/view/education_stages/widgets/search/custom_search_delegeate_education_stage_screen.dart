import 'package:drosak_m_app/core/database/sqlite/education_stage_operation.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/view/education_stages/widgets/search/custom_list_search_education_stage_screen.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegetedEducationStageScreen extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    EducationStageOperation educationStageOperation = EducationStageOperation();
    return query == ''
        ? const SizedBox()
        : CustomListSearchEducationStageScreen(
            getSearchItemStage:
                educationStageOperation.getSearchWord(searchWord: query));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text(
        "buildSuggestions",
        style: TextStyle(color: ColorManager.kWhiteColor),
      ),
    );
  }
}
