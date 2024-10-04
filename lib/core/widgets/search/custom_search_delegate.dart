import 'package:drosak_m_app/core/database/sqlite/education_stage_operation.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:drosak_m_app/view/education_stages/widgets/search/custom_list_search_education_stage_screen.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegated extends SearchDelegate<String> {
  Widget Function(String query) myBuildResult;

  CustomSearchDelegated({
    required this.myBuildResult,
  });

  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    return super.appBarTheme(context).copyWith(
        textTheme: super.appBarTheme(context).textTheme.copyWith(
            titleLarge: TextStyle(
                color: ColorManager.kWhiteColor, fontSize: FontsSize.f20)),
        appBarTheme: const AppBarTheme(color: ColorManager.kPrimaryColor),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: ColorManager.kWhiteColor),
        ));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(
            Icons.close,
            color: ColorManager.kWhiteColor,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: const Icon(
          Icons.arrow_back,
          color: ColorManager.kWhiteColor,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    // EducationStageOperation educationStageOperation = EducationStageOperation();
    // return query == ''
    //     ? const SizedBox()
    //     : CustomListSearchEducationStageScreen(
    //   getSearchItemStage:
    //   educationStageOperation.getSearchWord(searchWord: query),
    //   editFun: editFun,
    //   deleteFun: deleteFun,
    // );
    return myBuildResult(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(
      child: Text(
        ConstValue.kContentSearch,
        style: TextStyle(color: ColorManager.kWhiteColor),
      ),
    );
  }
}
