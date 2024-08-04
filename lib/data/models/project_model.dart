import 'package:caparc/common/models/base_model.dart';
import 'package:caparc/data/models/user_model.dart';

class ProjectModel extends BaseModel {
  String title;
  String createdById;
  List<String> authorNames;
  List<UserModel> authorAccounts;
  List<UserModel> viewedBy;
  List<UserModel> downloadedBy;
  List<UserModel> favoriteBy;
  DateTime approvedOn;
  List<String> keywords;
  String abstract;
  String file;

  ProjectModel(
      {required String id,
      required DateTime createdAt,
      required this.title,
      required this.createdById,
      required this.authorNames,
      required this.authorAccounts,
      required this.viewedBy,
      required this.downloadedBy,
      required this.favoriteBy,
      required this.approvedOn,
      required this.keywords,
      required this.abstract,
      required this.file})
      : super(id: id, createdAt: createdAt);

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'title': title,
      'createdById': createdById,
      'authorNames': authorNames,
      'authorAccounts': authorAccounts,
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
