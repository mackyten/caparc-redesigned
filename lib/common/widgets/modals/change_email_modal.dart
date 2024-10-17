import 'package:caparc/common/values.dart';
import 'package:caparc/common/widgets/buttons/profile_button.dart';
import 'package:caparc/common/widgets/dialogs/success_dialog.dart';
import 'package:caparc/common/widgets/modals/01custom_modal.dart';
import 'package:caparc/common/widgets/spacers.dart';
import 'package:caparc/common/widgets/text_form_field.dart';
import 'package:caparc/common/models/user_model.dart';
import 'package:caparc/services/auth_service/auth_service.dart';
import 'package:flutter/material.dart';
import 'password_reauth_modal.dart';

void showChangeEmailModal(
  BuildContext context,
  UserModel user,
) {
// Declare a FocusNode for the text field
  UserModel data = user.copyWith();
  String? email = "";
  String? confirmEmail = "";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Change Email",
                    style: titleStyle,
                  ),
                  Spacers.formFieldSpacers(),
                  TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(labelText: "Current Email"),
                    enabled: false,
                    initialValue: data.email,
                  ),
                  Spacers.formFieldSpacers(),
                  TextFormField(
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      enableSuggestions: false,
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                    decoration: const InputDecoration(labelText: "New Email"),
                      validator: (validator) {
                        if (email != confirmEmail) {
                          return "Email does not matched";
                        } else if (validator == null || validator.isEmpty) {
                          return "Please enter your new email";
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      }),
                  Spacers.formFieldSpacers(),
                  TextFormField(
                    maxLines: 1,
                    keyboardType: TextInputType.emailAddress,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    decoration: const InputDecoration(labelText: "Confirm New Email"),
                    validator: (validator) {
                      if (email != confirmEmail) {
                        return "Email does not matched";
                      } else if (validator == null || validator.isEmpty) {
                        return "Please enter your new email";
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        confirmEmail = val;
                      });
                    },
                  ),
                  Spacers.formFieldSpacers(),
                  SizedBox(
                    width: double.infinity,
                    child: ProceedButton(
                        onPressed: confirmEmail!.isEmpty || email!.isEmpty
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  showPasswordReauthModal(
                                    context: context,
                                    onProceed: (password) {
                                      IFirebaseAuthService firebaseAuthService =
                                          FirebaseAuthService();
                                      firebaseAuthService
                                          .reathenticateThenChangeEmail(
                                              password: password!,
                                              newEmail: email!,
                                              onError: () {},
                                              onSuccess: (currentUser) {
                                                showSuccessDialog(
                                                        context: context,
                                                        message:
                                                            "Verification email has been sent to $email.")
                                                    .then((value) =>
                                                        Navigator.pushNamed(
                                                            context, '/'));
                                              });
                                    },
                                  );
                                }
                              }),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}
