import 'package:caparc/common/models/base_model.dart';

class TestModel extends BaseModel {
  String title;

  TestModel(
      {required String id, required DateTime createdAt, required this.title})
      : super(id: id, createdAt: createdAt);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'title': title,
    };
  }

  factory TestModel.fromJson(Map<String, dynamic> json) {
    // Call parent class's fromJson method and pass remaining JSON to the constructor
    return TestModel(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      title: json['title'],
    );
  }
}
