import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> showSuccessDialog(
    {required BuildContext context, String? message}) {
  return showAdaptiveDialog(
      context: context,
      builder: (_) {
        return CupertinoAlertDialog(
          title: const Text("Yayy!!"),
          content: message != null
              ? SizedBox(
                  child: Text(
                    message,
                  ),
                )
              : null,
          actions: [
            CupertinoButton(
              child: const Text("Continue"),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      });
}
