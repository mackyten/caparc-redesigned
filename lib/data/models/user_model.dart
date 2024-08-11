import 'package:caparc/common/enums/account_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  UserModel(
      {required this.id,
      required this.firstname,
      required this.middlename,
      required this.lastname,
      this.suffix,
      this.prefix,
      required this.birthdate,
      required this.idNumber,
      required this.accountStatus,
      required this.email,
      required this.password});

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
      'accountStatus': accountStatus.index,
      'email': email,
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
        password: json['password'] ?? '');
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
}
