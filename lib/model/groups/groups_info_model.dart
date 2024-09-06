import 'package:drosak_m_app/model/groups/appointment_model.dart';
import 'package:drosak_m_app/model/groups/group_details.dart';

class GroupInfoModel {
  GroupDetails groupDetails;
  List<AppointmentModel> listAppointment;

  GroupInfoModel({required this.groupDetails, required this.listAppointment});

  @override
  String toString() {
    return 'GroupInfoModel{groupDetails: $groupDetails, listAppointment: $listAppointment}';
  }
}
