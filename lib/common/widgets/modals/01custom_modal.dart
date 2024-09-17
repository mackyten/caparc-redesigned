import 'package:caparc/common/ca_colors.dart';
import 'package:flutter/material.dart';

void showCABottomSheet(
    {required BuildContext context,
    required Widget Function(BuildContext) builder}) {
  showModalBottomSheet(
    showDragHandle: true,
    context: context,
    backgroundColor: CAColors.appBG,
    isScrollControlled: true,
    builder: builder,
  );
}
