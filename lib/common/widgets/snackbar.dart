import 'package:caparc/common/ca_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CASnackbar {
  static error(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      backgroundColor: CAColors.danger,
    ));
  }
}
