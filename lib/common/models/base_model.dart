class BaseModel {
  String id;
  DateTime createdAt;

  BaseModel({required this.id, required this.createdAt});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': DateTime.now(),
    };
  }

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    return BaseModel(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
