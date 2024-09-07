import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showErrorDialog({required BuildContext context, String? message}) {
  return showAdaptiveDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Text(
            "Oh no!!",
          ),
          content: message != null
              ? SizedBox(
                  child: Text(
                    message,
                  ),
                )
              : null,
          actions: [
            CupertinoButton(
              child: const Text(
                "Okay, I understand",
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      });
}
