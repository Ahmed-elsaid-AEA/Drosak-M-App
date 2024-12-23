import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:drosak_m_app/core/database/sqlite/education_stage_operation.dart';
import 'package:drosak_m_app/core/database/sqlite/groups_operation.dart';
import 'package:drosak_m_app/core/database/sqlite/students_operation.dart';
import 'package:drosak_m_app/core/resources/const_values.dart';
import 'package:drosak_m_app/core/resources/fonts_manager.dart';
import 'package:drosak_m_app/core/widgets/dialog/show_custom_dialog_choose_image_oprtion.dart';
import 'package:drosak_m_app/model/education_stages/item_stage_model.dart';
import 'package:drosak_m_app/model/groups/appointment_model.dart';
import 'package:drosak_m_app/model/groups/group_details.dart';
import 'package:drosak_m_app/model/student_model.dart';
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
  GroupDetails? selectedGroupDetails;
  String? pathImage;
  StudentModel? studentModel;

  ///steam of education stage screen
  late StreamController<List<ItemStageModel>> controllerListItemStageModel;
  late Sink<List<ItemStageModel>> inputDataListItemStageModel;
  late Stream<List<ItemStageModel>> outPutDataListItemStageModel;

  ///steam of groups
  late StreamController<List<GroupDetails>> controllerListItemGroupsDetails;
  late Sink<List<GroupDetails>> inputDataListItemGroupsDetails;
  late Stream<List<GroupDetails>> outPutDataListItemGroupsDetails;

  ///steam of list Time Day Group Model
  late StreamController<List<AppointmentModel>> controllerListAppointment;
  late Sink<List<AppointmentModel>> inputDataAppointment;
  late Stream<List<AppointmentModel>> outPutDataListAppointment;

  ///steam of list initial selected item stage
  late StreamController<ItemStageModel> _controllerInitialItemSelectedStage;
  late Sink<ItemStageModel> _inputPutDataInitialItemSelectedStage;
  late Stream<ItemStageModel> outPutDataInitialItemSelectedStage;

  ///steam of initial Selected Group
  late StreamController<GroupDetails?> _controllerInitialItemSelectedGroup;
  late Sink<GroupDetails?> _inputPutDataInitialItemSelectedGroup;
  late Stream<GroupDetails?> outPutDataInitialItemSelectedGroup;

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

    ///init steam of initial selected group stage screen
    _controllerInitialItemSelectedGroup = StreamController();
    _inputPutDataInitialItemSelectedGroup =
        _controllerInitialItemSelectedGroup.sink;
    outPutDataInitialItemSelectedGroup =
        _controllerInitialItemSelectedGroup.stream.asBroadcastStream();

    ///init steam of List Time Day Group Model
    controllerListAppointment = StreamController();
    inputDataAppointment = controllerListAppointment.sink;
    outPutDataListAppointment =
        controllerListAppointment.stream.asBroadcastStream();

    ///init steam of List Group Details
    controllerListItemGroupsDetails = StreamController();
    inputDataListItemGroupsDetails = controllerListItemGroupsDetails.sink;
    outPutDataListItemGroupsDetails =
        controllerListItemGroupsDetails.stream.asBroadcastStream();

    ///init steam initial data
    _controllerInitialItemSelectedStage = StreamController();
    _inputPutDataInitialItemSelectedStage =
        _controllerInitialItemSelectedStage.sink;
    outPutDataInitialItemSelectedStage =
        _controllerInitialItemSelectedStage.stream.asBroadcastStream();
  }

  void initAllData() async {
    await putImageIntoStream();
    await getAllItemStageModelList();
    //?check in edit
    if (studentModel != null) {
      fillDataStudentModel();
    }
  }

  Future<void> putImageIntoStream() async {
    inputPathImage.add(pathImage);
  }

  void disposeControllers() {
    ///dispose steam of education stage screen
    controllerListItemStageModel.close();
    inputDataListItemStageModel.close();

    ///dispose steam of initial selected group
    _controllerInitialItemSelectedGroup.close();
    _inputPutDataInitialItemSelectedGroup.close();

    ///dispose steam of List Time Day Group Model
    controllerListAppointment.close();
    inputDataAppointment.close();

    ///dispose steam of List   Groups Details Model
    controllerListItemGroupsDetails.close();
    inputDataListItemGroupsDetails.close();

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
        status = arguments[ConstValue.kStatus].toString();
        studentModel = arguments[ConstValue.kStudentModel];
      } else {
        //? now in add new
        status = arguments.toString();
      }
    }
  }

  onChangedSelectEducationStageName(ItemStageModel? p1) {
    selectedEducationStage = p1;
    if (selectedEducationStage != null) getGroupsByEducationStageName();
  }

  onChangedSelectGroupsName(GroupDetails? p1) {
    selectedGroupDetails = p1;
    if (selectedGroupDetails != null) getAppointmentGroupsByGroupName();
  }

  Future<void> getGroupsByEducationStageName() async {
    GroupsOperation groupsOperation = GroupsOperation();
    List<GroupDetails> listGroup =
        await groupsOperation.getGroupInnerJoinEducationStage(
            educationID: selectedEducationStage!.id);
    inputDataAppointment.add([]);
    selectedGroupDetails = null;
    _inputPutDataInitialItemSelectedGroup.add(selectedGroupDetails);
    inputDataListItemGroupsDetails.add(listGroup);
    if (listGroup.isNotEmpty) {
      selectedGroupDetails = listGroup[0];
      _inputPutDataInitialItemSelectedGroup.add(selectedGroupDetails);
    }
  }

  Future<void> getAppointmentGroupsByGroupName() async {
    GroupsOperation groupsOperation = GroupsOperation();
    List<AppointmentModel> listAppointment =
        await groupsOperation.getAppointmentsGroupInnerJoinGroupsTable(
            groupId: selectedGroupDetails!.id);
    _inputPutDataInitialItemSelectedGroup.add(selectedGroupDetails);

    inputDataAppointment.add(listAppointment);
  }

  void _closeKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void backToMainScreen(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onPressedAtEditORSave() async {
    if (status == ConstValue.kEditThisStudent) {
      await editAll();
    } else if (status == ConstValue.kAddNewStudent) {
      await saveAll();
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

  Future<void> saveAll() async {
    String requiredData = checkRequiredData();
    if (requiredData.trim().isEmpty) {
      //?now Insert To Data Base
      await insertNewStudent();
      print("now insert");
    } else {
      //? show alert
      showAlertForRequiredData(requiredData);
    }
  }

  String checkRequiredData() {
    String requiredData = "";
    if (controllerStudentName.text.trim().isEmpty) {
      requiredData += " , ${ConstValue.kEnterNameStudent}";
    }
    if (pathImage == null) {
      requiredData += " , ${ConstValue.kSelectImageStudent}";
    }
    if (selectedEducationStage == null) {
      requiredData += " , ${ConstValue.kSelectEducationStage}";
    }
    if (selectedGroupDetails == null) {
      requiredData += " , ${ConstValue.kSelectGroups}";
    }
    return requiredData;
  }

  void showAlertForRequiredData(String requiredData) {
    if (requiredData.trim().startsWith(",")) {
      requiredData.replaceFirst(",", "");
    }
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      requiredData,
      style: TextStyle(
        fontSize: FontsSize.f14,
        fontWeight: FontWeight.bold,
        fontFamily: FontsName.geDinerOneFont,
      ),
    )));
  }

  Future<void> insertNewStudent() async {
    StudentOperation studentOperation = StudentOperation();
    int studentId = await studentOperation.insertNewStudent(StudentModel(
        name: controllerStudentName.text.trim(),
        id: 0,
        image: pathImage!,
        createdAt: 'createdAt',
        idGroup: selectedGroupDetails!.id,
        note: controllerStudentNote.text.trim()));

    if (studentId > 0) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        ConstValue.kAddedNewStudentSucces,
        style: TextStyle(
          fontSize: FontsSize.f14,
          fontWeight: FontWeight.bold,
          fontFamily: FontsName.geDinerOneFont,
        ),
      )));
    }
  }

  void fillDataStudentModel() {
    //?put name
    controllerStudentName.text = studentModel!.name;

    //?put note
    controllerStudentNote.text = studentModel!.note;

    //?put image
    pathImage = studentModel!.image;
    inputPathImage.add(pathImage);
    //?fill selected education
    selectedEducationStage = listItemStageModel
        .where((element) => element.id == studentModel!.idEducationStage)
        .toList()[0];
    _inputPutDataInitialItemSelectedStage.add(selectedEducationStage!);

    //?fill selected group
    onChangedSelectEducationStageName(selectedEducationStage);
  }

  Future<void> editAll() async {
    String requiredData = checkRequiredData();
    if (requiredData.trim().isEmpty) {
      //?now edit To Data Base
      await editIntoStudentInfo();
    } else {
      //? show alert
      showAlertForRequiredData(requiredData);
    }
  }

  Future<void> editIntoStudentInfo() async {
    StudentOperation studentOperation = StudentOperation();
    bool updated = await studentOperation.editStudentData(StudentModel(
        name: controllerStudentName.text.trim(),
        id: studentModel!.id,
        image: pathImage!,
        idGroup: selectedGroupDetails!.id,
        note: controllerStudentNote.text.trim()));

    if (updated == true) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        ConstValue.kUpdateThisStudentSucces,
        style: TextStyle(
          fontSize: FontsSize.f14,
          fontWeight: FontWeight.bold,
          fontFamily: FontsName.geDinerOneFont,
        ),
      )));
    }
  }
}
