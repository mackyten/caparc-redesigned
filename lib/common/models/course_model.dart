import 'package:caparc/common/models/base_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel extends BaseModel {
  final String? description;
  final String? code;
  CourseModel({
    required super.id,
    required super.createdAt,
    required this.description,
    this.code,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
        id: json['id'],
        createdAt: json['createdAt'] == null
            ? DateTime(1)
            : (json['createdAt'] as Timestamp).toDate(),
        description: json['description'],
        code: json["code"]);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
