import 'dart:async';
import 'dart:io';

import 'package:drosak_m_app/core/database/sqlite/education_stage_operation.dart';
import 'package:drosak_m_app/core/resources/assets_values_mananger.dart';
import 'package:drosak_m_app/core/resources/colors_manager.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/resources/width_manager.dart';
import 'package:drosak_m_app/core/widgets/space/horizontal_space.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:drosak_m_app/view/education_stages/widgets/body/custom_add_new_eudcation_stage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EducationStagesController {
  List<ItemStageModel> listItemStageModel = [];
  TextEditingController controllerNameEducationStage = TextEditingController();
  TextEditingController controllerDescEducationStage = TextEditingController();
  String? pathImage;
  late StreamController<List<ItemStageModel>> controllerListItemStageModel;
  late Sink<List<ItemStageModel>> inputDataListItemStageModel;
  late Stream<List<ItemStageModel>> outPutDataListItemStageModel;
  late StreamController<String?> controllerPathImage;
  late Sink<String?> inputPathImage;
  late Stream<String?> outPutPathImage;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  EducationStagesController() {
    init();
  }

  void initControllers() {
    controllerListItemStageModel = StreamController();
    inputDataListItemStageModel = controllerListItemStageModel.sink;
    outPutDataListItemStageModel =
        controllerListItemStageModel.stream.asBroadcastStream();
    controllerPathImage = StreamController();
    inputPathImage = controllerPathImage.sink;
    outPutPathImage = controllerPathImage.stream.asBroadcastStream();
    inputPathImage.add(pathImage);
  }

  void disposeControllers() {
    inputDataListItemStageModel.close();
    controllerListItemStageModel.close();
    inputPathImage.close();
    controllerPathImage.close();
    controllerNameEducationStage.dispose();
    controllerDescEducationStage.dispose();
  }

  init() async {
    initControllers();
    getAllItemList();
  }

  void getAllItemList() async {
    EducationStageOperation educationStageOperation = EducationStageOperation();
    listItemStageModel = await educationStageOperation.getAllEducationData();
    inputDataListItemStageModel.add(listItemStageModel);
  }

  void pickImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: imageSource);
    if (image != null) {
      pathImage = image.path;
      saveImagesOfMyApp(image);
    }
    inputPathImage.add(pathImage);
  }

  void saveImagesOfMyApp(XFile image) async {
    Directory directory = await getApplicationDocumentsDirectory();
    var directoryPath = directory.path;
    var finalPath = "$directoryPath/${image.name}";
    File fileImage = await File(image.path).copy(finalPath);
    pathImage = fileImage.path;
  }

  void openBottomSheet({required BuildContext context}) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => CustomAddNewEducationStage(
        onPressedPickImage: () {
          showCustomDialogChooseImage(context);
        },
        controllerNameEducationStage: controllerNameEducationStage,
        controllerDescEducationStage: controllerDescEducationStage,
        onPressedAdd: () async {
          if (formKey.currentState!.validate() == true) {
            bool inserted = await addNewEducation();
            if (inserted == true) {
              Navigator.pop(context);

              listItemStageModel.add(ItemStageModel(
                  id: listItemStageModel.length + 1,
                  stageName: controllerNameEducationStage.text,
                  desc: controllerDescEducationStage.text,
                  image: pathImage == null ? "" : pathImage!));
              inputDataListItemStageModel.add(listItemStageModel);
              controllerNameEducationStage.clear();
              controllerDescEducationStage.clear();
              pathImage = null;
            }
          }
        },
        onPressedDeleteImage: () {
          pathImage = null;
          inputPathImage.add(pathImage);
        },
        outPathImage: outPutPathImage,
        formKey: formKey,
      ),
    );
  }

  Future<bool> addNewEducation() async {
    EducationStageOperation educationStageOperation = EducationStageOperation();

    bool inserted = await educationStageOperation.insertEducationDetails(
        ItemStageModel(
            id: 0,
            stageName: controllerNameEducationStage.text,
            desc: controllerDescEducationStage.text,
            image: pathImage == null ? "" : pathImage!));
    return inserted;
  }

  void showCustomDialogChooseImage(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton.filled(
                iconSize: 50,
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.kPrimaryColor),
                onPressed: () {
                  pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.image)),
            HorizontalSpace(WidthManager.w30),
            IconButton.filled(
                iconSize: 50,
                style: ElevatedButton.styleFrom(
                    backgroundColor: ColorManager.kPrimaryColor),
                onPressed: () {
                  pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.camera_alt)),
          ],
        ),
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton.filled(
              iconSize: 10,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                size: 20,
                Icons.close,
                color: ColorManager.kWhiteColor,
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
            Text(
              ConstValue.kChooseFrom,
              style: TextStyle(
                  fontFamily: FontsName.geDinerOneFont,
                  fontWeight: FontWeight.w900,
                  fontSize: FontsSize.f15),
            )
          ],
        ),
      ),
    );
  }
}
