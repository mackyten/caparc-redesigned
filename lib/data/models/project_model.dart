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
  String? projectAbstract;
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
      this.projectAbstract,
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
      'projectAbstract': projectAbstract,
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
        projectAbstract: json['abstract'],
        file: json['file']);
  }

  ProjectModel copyWith({
    String? title,
    String? createdById,
    List<String>? authorNames,
    List<UserModel>? authorAccounts,
    List<UserModel>? viewedBy,
    List<UserModel>? downloadedBy,
    List<UserModel>? favoriteBy,
    DateTime? approvedOn,
    List<String>? keywords,
    String? abstract,
    String? file,
  }) {
    return ProjectModel(
      id: this.id,
      createdAt: this.createdAt,
      title: title ?? this.title,
      createdById: createdById ?? this.createdById,
      authorNames: authorNames ?? this.authorNames,
      authorAccounts: authorAccounts ?? this.authorAccounts,
      viewedBy: viewedBy ?? this.viewedBy,
      downloadedBy: downloadedBy ?? this.downloadedBy,
      favoriteBy: favoriteBy ?? this.favoriteBy,
      approvedOn: approvedOn ?? this.approvedOn,
      keywords: keywords ?? this.keywords,
      projectAbstract: abstract ?? this.projectAbstract,
      file: file ?? this.file,
    );
  }
}
