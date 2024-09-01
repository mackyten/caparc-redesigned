import 'package:caparc/common/methods/fullname_builder.dart';
import 'package:caparc/common/enums/account_status.dart';
import 'package:caparc/common/models/course_model.dart';
import 'package:caparc/data/models/user_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

@immutable
class UserState {
  final String id;
  final String firstname;
  final String? middlename;
  final String lastname;
  final String? suffix;
  final String? prefix;
  final DateTime birthdate;
  final String idNumber;
  final AccountStatus accountStatus;
  final String email;
  final CourseModel? course;
  final PlatformFile? pickedAvatar;
  final String? avatarLink;

  const UserState({
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
    this.course,
    this.pickedAvatar,
    this.avatarLink,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'middlename': middlename,
      'lastname': lastname,
      'suffix': suffix,
      'prefix': prefix,
      'birthdate': birthdate,
      'idNumber': idNumber,
      'accountStatus': accountStatus,
      'email': email,
      'course': course?.id,
      'avatarLink': avatarLink
    };
  }

  String getFullname() {
    UserModel item = UserModel(
        id: id,
        firstname: firstname,
        middlename: middlename,
        lastname: lastname,
        birthdate: birthdate,
        idNumber: idNumber,
        accountStatus: accountStatus,
        email: '',
        password: '');
    return Fullname.buildFullname(item);
  }

  UserModel toUserModel() {
    return UserModel(
      id: id,
      firstname: firstname,
      middlename: middlename,
      lastname: lastname,
      birthdate: birthdate,
      idNumber: idNumber,
      accountStatus: accountStatus,
      email: email,
      password: '',
      course: course,
      avatarLink: avatarLink,
    );
  }
}
