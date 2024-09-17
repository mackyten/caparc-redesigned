import 'package:caparc/blocs/user_bloc/state.dart';
import 'package:caparc/common/enums/account_status.dart';
import 'package:caparc/common/models/course_model.dart';
import 'package:caparc/services/firestore_service/query_service.dart';
import 'package:caparc/services/storage_service/query_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

class UserModel {
  String id;
  String firstname;
  String? middlename;
  String lastname;
  String? suffix;
  String? prefix;
  DateTime birthdate;
  String idNumber;
  AccountStatus accountStatus;
  String email;
  String password;
  CourseModel? course;
  PlatformFile? pickedAvatar;
  String? avatarLink;

  UserModel({
    required this.id,
    required this.firstname,
    required this.middlename,
    required this.lastname,
    this.suffix,
    this.prefix,
    required this.birthdate,
    required this.idNumber,
    required this.accountStatus,
    required this.email,
    required this.password,
    this.course,
    this.avatarLink,
    this.pickedAvatar,
  });

  Map<String, dynamic> toJson() {
    assert(email.isNotEmpty, "Email cannot be empty.");
    return {
      'id': id,
      'firstname': firstname,
      'middlename': middlename,
      'lastname': lastname,
      'suffix': suffix,
      'prefix': prefix,
      'birthdate': birthdate,
      'idNumber': idNumber,
      'accountStatus': accountStatus.index,
      'email': email,
      'course': course?.toJson(),
      'avatarLink': avatarLink
      // 'password': password,
    };
  }

  Map<String, dynamic> toJsonIdOnly() {
    return {
      'id': id,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        firstname: json['firstname'],
        middlename: json['middlename'],
        lastname: json['lastname'],
        suffix: json['suffix'],
        prefix: json['prefix'],
        birthdate: (json['birthdate'] as Timestamp).toDate(),
        idNumber: json['idNumber'],
        accountStatus: AccountStatus.values[json['accountStatus']],
        email: json['email'],
        password: json['password'] ?? '',
        avatarLink: json['avatarLink']);
  }

  static Future<UserModel> fromJsonAsync(Map<String, dynamic> json) async {
    FirestoreQueryInterface firestoreQueryInterface = FirestoreQuery();

    CourseModel? course = CourseModel.fromJson(json['course']);
    String? avatarLink;
    if (course.description == null) {
      course = await firestoreQueryInterface.getCourseById(course.id);
    }

    if (json['avatarLink'] != null) {
      IStorageQueryService iStorageQueryService = StorageQueryService();
      avatarLink =
          await iStorageQueryService.getDownloadURL(json['avatarLink']);
    }

    return UserModel(
      id: json['id'],
      firstname: json['firstname'],
      middlename: json['middlename'],
      lastname: json['lastname'],
      suffix: json['suffix'],
      prefix: json['prefix'],
      birthdate: (json['birthdate'] as Timestamp).toDate(),
      idNumber: json['idNumber'],
      accountStatus: AccountStatus.values[json['accountStatus']],
      email: json['email'],
      password: json['password'] ?? '',
      course: course,
      avatarLink: avatarLink,
    );
  }

  UserModel copyWith({
    String? id,
    String? firstname,
    String? middlename,
    String? lastname,
    String? suffix,
    String? prefix,
    DateTime? birthdate,
    String? idNumber,
    AccountStatus? accountStatus,
    String? email,
    String? password,
    String? avatarLink,
  }) {
    return UserModel(
        id: id ?? this.id,
        firstname: firstname ?? this.firstname,
        middlename: middlename ?? this.middlename,
        lastname: lastname ?? this.lastname,
        birthdate: birthdate ?? this.birthdate,
        idNumber: idNumber ?? this.idNumber,
        accountStatus: accountStatus ?? this.accountStatus,
        email: email ?? this.email,
        password: password ?? this.password,
        avatarLink: avatarLink ?? this.avatarLink);
  }

  String getFullName() {
    List<String> nameParts = [];

    if (prefix != null && prefix!.isNotEmpty) {
      nameParts.add(prefix!);
    }

    nameParts.add(firstname);

    if (middlename != null && middlename!.isNotEmpty) {
      nameParts.add(middlename!);
    }

    nameParts.add(lastname);

    if (suffix != null && suffix!.isNotEmpty) {
      nameParts.add(suffix!);
    }

    return nameParts.join(' ');
  }

  UserState toUserState() {
    return UserState(
      id: id,
      firstname: firstname,
      middlename: middlename,
      lastname: lastname,
      birthdate: birthdate,
      idNumber: idNumber,
      accountStatus: accountStatus,
      email: email,
      course: course,
      avatarLink: avatarLink,
    );
  }

  String getAge() {
    DateTime now = DateTime.now();
    final int diffInDays = now.difference(birthdate).inDays;

    switch (diffInDays) {
      case int n when n < 30:
        return "$diffInDays do";
      case int n when n < 365:
        final int diffInMonths = (diffInDays / 30).floor();
        return "$diffInMonths mo";
      case int n when n > 365:
        final int diffInYears = (diffInDays / 365).floor();
        return "$diffInYears yo";
      default:
        return "Age";
    }
  }
}
