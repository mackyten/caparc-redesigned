import 'package:caparc/common/values.dart';
import 'package:caparc/common/widgets/buttons/profile_button.dart';
import 'package:caparc/common/widgets/dialogs/error_dialog.dart';
import 'package:caparc/common/widgets/dialogs/success_dialog.dart';
import 'package:caparc/common/widgets/modals/01custom_modal.dart';
import 'package:caparc/common/widgets/modals/password_reauth_modal.dart';
import 'package:caparc/common/widgets/spacers.dart';
import 'package:caparc/common/widgets/text_form_field.dart';
import 'package:caparc/services/auth_service/auth_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void showChangePasswordModal({required BuildContext context}) {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? password = "";
  String? confirmPassword = "";
  showCABottomSheet(
    context: context,
    builder: (_) {
      return StatefulBuilder(builder: (_, setState) {
        return Padding(
          padding: EdgeInsets.only(
            left: bodyPadding,
            right: bodyPadding,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Change Password",
                    style: titleStyle,
                  ),
                  Spacers.formFieldSpacers(),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "New Password"),
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  Spacers.formFieldSpacers(),
                  TextFormField(
                    decoration: const InputDecoration(labelText: "Confirm Password"),
                    onChanged: (val) {
                      setState(() {
                        confirmPassword = val;
                      });
                    },
                  ),
                  Spacers.formFieldSpacers(),
                  SizedBox(
                    width: double.infinity,
                    child: ProceedButton(
                        onPressed: password!.isEmpty || password!.isEmpty
                            ? null
                            : () async {
                                IFirebaseAuthService firebaseAuthService =
                                    FirebaseAuthService();
                                await firebaseAuthService
                                    .changePassword(newPassword: password!)
                                    .then((value) {
                                  showSuccessDialog(
                                          context: context,
                                          message:
                                              "Your password has successfully updated.")
                                      .then((value) =>
                                          Navigator.of(context).pop());
                                }).onError((error, stackTrace) {
                                  showPasswordReauthModal(
                                    context: context,
                                    onProceed: (_) async {
                                      await firebaseAuthService
                                          .changePassword(
                                              newPassword: password!)
                                          .onError((error, stackTrace) {
                                        showErrorDialog(
                                                context: context,
                                                message: "$error")
                                            .then((value) =>
                                                Navigator.of(context).pop());
                                      });
                                    },
                                  );
                                }).catchError((e) {
                                  if (kDebugMode) {
                                    print("CATCHED IN catchError: $e");
                                  }
                                });
                              }),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}
