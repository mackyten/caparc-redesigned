import 'package:caparc/common/ca_colors.dart';
import 'package:flutter/material.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

class Buttons {
  static Widget verifyButton({
    required VoidCallback onTap,
    bool? isVerifying,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
            //padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
            decoration: BoxDecoration(
                color: CAColors.primary,
                borderRadius: BorderRadius.circular(20),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black.withOpacity(0.30),
                      offset: const Offset(0, 3),
                      blurRadius: 5)
                ]),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      child: isVerifying == true
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator.adaptive(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    CAColors.secondary),
                              ),
                            )
                          : const Icon(
                              MingCuteIcons.mgc_check_2_fill,
                              color: CAColors.secondary,
                            ),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 40,
                  width: isVerifying == true ? 120 : 100,
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: Center(
                    child: Text(
                      isVerifying == true ? "VERIFYING..." : "VERIFY",
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  static Widget sumbitButton({
    required VoidCallback onTap,
    bool? isSubmitting,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
            //padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
            decoration: BoxDecoration(
                color: CAColors.primary,
                borderRadius: BorderRadius.circular(20),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black.withOpacity(0.30),
                      offset: const Offset(0, 3),
                      blurRadius: 5)
                ]),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      child: isSubmitting == true
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator.adaptive(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    CAColors.secondary),
                              ),
                            )
                          : const Icon(
                              MingCuteIcons.mgc_check_2_fill,
                              color: CAColors.secondary,
                            ),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 40,
                  width: isSubmitting == true ? 120 : 100,
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: Center(
                    child: Text(
                      isSubmitting == true ? "SUBMITTING..." : "SUBMIT",
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  static Widget continueButton({
    required VoidCallback onTap,
    bool? isLoading,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
            //padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
            decoration: BoxDecoration(
                color: CAColors.primary,
                borderRadius: BorderRadius.circular(20),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black.withOpacity(0.30),
                      offset: const Offset(0, 3),
                      blurRadius: 5)
                ]),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      child: isLoading == true
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator.adaptive(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    CAColors.primary),
                              ),
                            )
                          : const Icon(
                              MingCuteIcons.mgc_arrow_right_fill,
                              color: CAColors.primary,
                            ),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 40,
                  width: 120,
                  padding: const EdgeInsets.only(left: 10, right: 20),
                  child: Center(
                    child: Text(
                      isLoading == true ? "LOADING..." : "CONTINUE",
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  static Widget cancelButton({required VoidCallback? ontap, String? label}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: ontap,
        borderRadius: BorderRadius.circular(40),
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              label ?? "CANCEL",
              style: const TextStyle(color: Colors.grey, letterSpacing: 2),
            ),
          ),
        ),
      ),
    );
  }
}
