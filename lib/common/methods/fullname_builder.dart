import 'package:caparc/data/models/user_model.dart';

class Fullname {
  static buildFullname(UserModel item) {
    var prefix = item.prefix == null ? '' : '${item.prefix} ';
    var firstname = '${item.firstname} ';
    var middlename = (item.middlename == null || item.middlename!.isEmpty) ? '' : '${item.middlename} ';
    var lastname = '${item.lastname} ';
    var suffix = item.suffix == null ? '' : '${item.suffix} ';

    return prefix + firstname + middlename + lastname + suffix;
  }
}
