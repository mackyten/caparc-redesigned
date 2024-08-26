import 'package:caparc/common/enums/account_status.dart';
import 'package:caparc/common/models/base_model.dart';
import 'package:caparc/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

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
  bool? isAccepted;
  PlatformFile? pickedFile;

  ProjectModel({
    required String id,
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
    this.file,
    this.isAccepted,
    this.pickedFile,
  }) : super(id: id, createdAt: createdAt);

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
      'favoriteBy': favoriteBy?.map((e) => e.id).toList(),
      'approvedOn': approvedOn,
      'keywords': keywords,
      'projectAbstract': projectAbstract,
      'file': file,
      'isAccepted': isAccepted
    };
  }

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
        id: json['id'],
        createdAt: (json['createdAt'] as Timestamp).toDate(),
        title: json['title'],
        createdById: json['createdById'],
        authorNames: json['authorNames'],
        authorAccounts: (json['authorAccounts'] as List)
            .map((e) => UserModel(
                id: e,
                firstname: '',
                middlename: 'middlename',
                lastname: 'lastname',
                birthdate: DateTime.now(),
                idNumber: 'idNumber',
                accountStatus: AccountStatus.verified,
                email: 'email',
                password: 'password'))
            .toList(),
        viewedBy: json['viewedBy'],
        downloadedBy: json['downloadedBy'],
        favoriteBy: json['favoriteBy'] != null
            ? (json['favoriteBy'] as List)
                .map((e) => UserModel(
                    id: e,
                    firstname: '',
                    middlename: 'middlename',
                    lastname: 'lastname',
                    birthdate: DateTime.now(),
                    idNumber: 'idNumber',
                    accountStatus: AccountStatus.verified,
                    email: 'email',
                    password: 'password'))
                .toList()
            : null,
        approvedOn: json['approvedOn'] != null
            ? ((json['approvedOn'] as Timestamp).toDate())
            : null,
        keywords: json['keywords'],
        projectAbstract: json['projectAbstract'],
        file: json['file'],
        isAccepted: json['isAccepted']);
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
