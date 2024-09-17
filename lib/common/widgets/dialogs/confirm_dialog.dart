import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showConfirmDialog({
  required BuildContext context,
  String? message,
  String? title,
  VoidCallback? onPressed,
}) {
  return showAdaptiveDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: title != null ? Text(title) : null,
          content: message != null
              ? SizedBox(
                  child: Text(
                    message,
                  ),
                )
              : null,
          actions: [
            CupertinoButton(
              child: const Text("Cancel"),
              onPressed: () {
                if (Navigator.canPop(context)) Navigator.of(context).pop();
              },
            ),
            CupertinoButton(
              child: const Text("Continue"),
              onPressed: () {
                if (onPressed != null) onPressed();
                if (Navigator.canPop(context)) Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
