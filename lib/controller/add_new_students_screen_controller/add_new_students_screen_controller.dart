import 'dart:async';
import 'dart:io';

import 'package:drosak_m_app/core/database/sqlite/education_stage_operation.dart';
import 'package:drosak_m_app/core/database/sqlite/groups_operation.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/widgets/dialog/show_custom_dialog_choose_image_oprtion.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:drosak_m_app/model/groups/appointment_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class AddNewStudentsScreenController {
  String status = ConstValue.kAddNewStudent;
  late StreamController<String?> controllerPathImage;
  late Sink<String?> inputPathImage;
  late Stream<String?> outPutPathImage;

  TextEditingController controllerStudentNote = TextEditingController();
  TextEditingController controllerStudentName = TextEditingController();
  GlobalKey<FormState> formStateStudentDetails = GlobalKey<FormState>();

  ItemStageModel? selectedEducationStage;
  String? pathImage;

  ///steam of education stage screen
  late StreamController<List<ItemStageModel>> controllerListItemStageModel;
  late Sink<List<ItemStageModel>> inputDataListItemStageModel;
  late Stream<List<ItemStageModel>> outPutDataListItemStageModel;

  ///steam of list Time Day Group Model
  late StreamController<List<AppointmentModel>> controllerListTimeDayGroupModel;
  late Sink<List<AppointmentModel>> inputDataListTimeDayGroupModel;
  late Stream<List<AppointmentModel>> outPutDataListTimeDayGroupModel;

  ///steam of list Time Day Group Model
  late StreamController<ItemStageModel> controllerInitialItem;
  late Sink<ItemStageModel> inputPutDataInitialItem;
  late Stream<ItemStageModel> outPutDataInitialItem;

  List<ItemStageModel> listItemStageModel = [];

//! global variable  context
  BuildContext context;

  AddNewStudentsScreenController(this.context) {
    start();
  }

  void start() async {
    await initControllers();
    initAllData();
  }

  Future<void> initControllers() async {
    ///init stream of image students
    controllerPathImage = StreamController();
    inputPathImage = controllerPathImage.sink;
    outPutPathImage = controllerPathImage.stream.asBroadcastStream();

    ///init steam of education stage screen
    controllerListItemStageModel = StreamController();
    inputDataListItemStageModel = controllerListItemStageModel.sink;
    outPutDataListItemStageModel =
        controllerListItemStageModel.stream.asBroadcastStream();

    ///init steam of List Time Day Group Model
    controllerListTimeDayGroupModel = StreamController();
    inputDataListTimeDayGroupModel = controllerListTimeDayGroupModel.sink;
    outPutDataListTimeDayGroupModel =
        controllerListTimeDayGroupModel.stream.asBroadcastStream();

    ///init steam initial data
    controllerInitialItem = StreamController();
    inputPutDataInitialItem = controllerInitialItem.sink;
    outPutDataInitialItem = controllerInitialItem.stream.asBroadcastStream();
  }

  void initAllData() async {
    await putImageIntoStream();
    await getAllItemStageModelList();
  }

  Future<void> putImageIntoStream() async {
    inputPathImage.add(pathImage);
  }

  void disposeControllers() {
    ///dispose steam of education stage screen
    controllerListItemStageModel.close();
    inputDataListItemStageModel.close();

    ///dispose steam of List Time Day Group Model
    controllerListTimeDayGroupModel.close();
    inputDataListTimeDayGroupModel.close();
  }

  Future<void> getAllItemStageModelList() async {
    EducationStageOperation educationStageOperation = EducationStageOperation();
    listItemStageModel = await educationStageOperation.getAllEducationData();
    inputDataListItemStageModel.add(listItemStageModel);
  }

  void getArgumentFromLastScreen(BuildContext context) {
    var arg = ModalRoute.of(context);
    if (arg != null) {
      var arguments = arg.settings.arguments;
      if (arguments is Map) {
        //? now in status edit
      } else {
        //? now in add new
        String argument = arguments.toString();
        status = argument;
      }
    }
  }

  onChangedSelectEducationStageName(ItemStageModel? p1) {
    selectedEducationStage = p1;
    if (selectedEducationStage != null) getGroupsByEducationStageName();
  }

  void getGroupsByEducationStageName() {
    GroupsOperation groupsOperation = GroupsOperation();
    groupsOperation.getGroupInnerJoinEducationStage(
        educationID: selectedEducationStage!.id);
  }

  void _closeKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void backToMainScreen(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onPressedAtEditORSave() async {
    if (status == ConstValue.kEditThisStudent) {
      //TODO:// now edit
      /*  bool updated = await editIntoGroupInfo();
      if (updated == true) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(ConstValue.kAddedGroupDetailsSucces)));
        backToMainScreen(context);
      }*/
    } else {
      //TODO://save data
    }
  }

  void onPressedPickImage() {
    showCustomDialogChooseImage(
      context: context,
      onPressedPickImageBYGallery: () {
        pickImage(ImageSource.gallery);
        Navigator.pop(context);
      },
      onPressedPickImageBYCamera: () {
        pickImage(ImageSource.camera);
        Navigator.pop(context);
      },
    );
  }

  void onPressedDeleteImage() {
    pathImage = null;
    putImageIntoStream();
  }

  void pickImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: imageSource);
    if (image != null) {
      pathImage = image.path;
      saveImagesOfMyApp(image);
    }
    await putImageIntoStream();
  }

  void saveImagesOfMyApp(XFile image) async {
    Directory directory = await getApplicationDocumentsDirectory();
    var directoryPath = directory.path;
    var finalPath = "$directoryPath/${image.name}";
    File fileImage = await File(image.path).copy(finalPath);
    pathImage = fileImage.path;
  }
}
