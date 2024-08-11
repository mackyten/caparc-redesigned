import 'package:caparc/common/models/base_model.dart';
import 'package:caparc/data/models/user_model.dart';

class ProjectModel extends BaseModel {
  String? title;
  String? createdById;
  List<String>? authorNames;
  List<UserModel>? authorAccounts;
  List<UserModel>? viewedBy;
  List<UserModel>? downloadedBy;
  List<UserModel>? favoriteBy;
  DateTime? approvedOn;
  List<String>? keywords;
  String? abstract;
  String? file;

  ProjectModel(
      {required String id,
      required DateTime createdAt,
      this.title,
      this.createdById,
      this.authorNames,
      this.authorAccounts,
      this.viewedBy,
      this.downloadedBy,
      this.favoriteBy,
      this.approvedOn,
      this.keywords,
      this.abstract,
      this.file})
      : super(id: id, createdAt: createdAt);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'title': title,
      'createdById': createdById,
      'authorNames': authorNames,
      'authorAccounts': authorAccounts?.map((e) => e.id).toList(),
      'viewedBy': viewedBy,
      'downloadedBy': downloadedBy,
      'favoriteBy': favoriteBy,
      'approvedOn': approvedOn,
      'keywords': keywords,
      'abstract': abstract,
      'file': file
    };
  }

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
        id: json['id'],
        createdAt: json['createdAt'],
        title: json['title'],
        createdById: json['createdById'],
        authorNames: json['authorNames'],
        authorAccounts: json['authorAccounts'],
        viewedBy: json['viewedBy'],
        downloadedBy: json['downloadedBy'],
        favoriteBy: json['favoriteBy'],
        approvedOn: json['approvedOn'],
        keywords: json['keywords'],
        abstract: json['abstract'],
        file: json['file']);
  }
}
