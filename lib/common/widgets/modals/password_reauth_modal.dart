import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../presentation/ca_colors.dart';
import '../spacers.dart';
import '../text_form_field.dart';

void showPasswordReauthModal(
    {required BuildContext context,
    required Function(String? password) onProceed}) {
  String? password;
  showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return CupertinoAlertDialog(
              title: const Text("Password needed!"),
              // titleTextStyle: GoogleFonts.poppins(
              //   fontSize: subtitleSize,
              //   color: CAColors.accent,
              // ),
              // icon: const Icon(MingCuteIcons.mgc_lock_line),
              content: Material(
                color: Colors.transparent,
                child: SizedBox(
                  width: 400,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Spacers.formFieldSpacers(),
                      CATextFormField(
                        maxLines: 1,
                        keyboardType: TextInputType.visiblePassword,
                        labelText: "Password",
                        enableSuggestions: false,
                        textCapitalization: TextCapitalization.none,
                        autocorrect: false,
                        obscureText: true,
                        onChange: (val) {
                          setState(() => password = val);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                if (Navigator.canPop(context))
                  CupertinoButton(
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.poppins(color: CAColors.error),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                CupertinoButton(
                    onPressed:
                        password == null ? null : () => onProceed(password),
                    child: const Text("Proceed")),
              ],
            );
          },
        );
      });
}
