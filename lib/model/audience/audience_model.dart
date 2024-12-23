import 'package:drosak_m_app/core/database/sqlite/my_sq_f_lite_databse.dart';

class AudienceModel {
  final int? id;
  final String status;
  final int studentID;
  final String selectedTimeData;
  final String? createdAt;

  AudienceModel({
    required this.status,
    required this.studentID,
    required this.selectedTimeData,
    this.createdAt,
    this.id,
  });

  factory AudienceModel.fromJson(Map<String, dynamic> json) {
    return AudienceModel(
        status: json['status'],
        studentID: json['student_id'],
        id: json['id'],
        createdAt: json['created_at'],
        selectedTimeData: json['detail']);
  }

  Map<String, dynamic> toJson() {
    return {
      MySqFLiteDatabase.audienceColumnDetail: selectedTimeData,
      MySqFLiteDatabase.audienceColumnIDStudent: studentID,
      MySqFLiteDatabase.audienceColumnStatus: status,
    };
  }
}
