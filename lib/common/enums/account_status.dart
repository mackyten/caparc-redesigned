import 'package:caparc/common/values.dart';
import 'package:caparc/common/ca_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

enum AccountStatus { none, pending, verified, blocked }

class AccountStatusHelper {
  static AccountStatusModel getStringValue(AccountStatus accountStatus) {
    final AccountStatusModel result = AccountStatusModel(
        value: AccountStatus.none,
        stringValue: "None",
        icon: Icon(
          Symbols.no_accounts,
          size: iconsSize,
          color: CAColors.deactivated,
        ));

    switch (accountStatus) {
      case AccountStatus.pending:
        return result
          ..value = AccountStatus.pending
          ..stringValue = "Pending"
          ..icon = Icon(
            CupertinoIcons.clock,
            size: iconsSize,
            color: CAColors.warning,
          );
      case AccountStatus.verified:
        return result
          ..value = AccountStatus.verified
          ..stringValue = "Verified"
          ..icon = Icon(
            Icons.verified,
            size: iconsSize,
            color: CAColors.success,
          );

      case AccountStatus.blocked:
        return result
          ..value = AccountStatus.blocked
          ..stringValue = "Blocked"
          ..icon = Icon(
            Icons.block,
            size: iconsSize,
            color: CAColors.danger,
          );
      default:
        return result;
    }
  }
}

class AccountStatusModel {
  AccountStatus value;
  String stringValue;
  Icon icon;

  AccountStatusModel(
      {required this.value, required this.stringValue, required this.icon});
}
