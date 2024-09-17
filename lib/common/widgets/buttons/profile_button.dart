import 'package:caparc/common/ca_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CAButtons {
  static proceed(Function()? onPressed) {
    return ProceedButton(
      onPressed: onPressed,
    );
  }
}

class ProceedButton extends StatelessWidget {
  final Function()? onPressed;

  const ProceedButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: CAColors.white,
        backgroundColor: CAColors.accent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 5,
      ),
      child: Text(
        "Proceed",
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget child;
  final bool? isLoading;
  const ProfileButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: CAColors.white,
        backgroundColor: CAColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 5,
      ),
      child: isLoading == true
          ? const SizedBox(
              width: double.infinity,
              child: SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: CAColors.white,
                ),
              ),
            )
          : child,
    );
  }
}
