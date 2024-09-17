import 'package:caparc/common/values.dart';
import 'package:caparc/common/widgets/spacers.dart';
import 'package:caparc/common/widgets/text_form_field.dart';
import 'package:caparc/common/ca_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class VerificationForm extends StatefulWidget {
  final Function(String?)? onChange;
  final String? Function(String?)? validator;
  final String? initialData;
  final bool isVerifying;
  final GlobalKey<FormState> formKey;
  const VerificationForm(
      {super.key,
      this.onChange,
      this.validator,
      this.initialData,
      required this.isVerifying,
      required this.formKey});

  @override
  State<VerificationForm> createState() => _VerificationFormState();
}

class _VerificationFormState extends State<VerificationForm> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              color: Colors.white,
              boxShadow: defaultBoxShadow,
              border: Border.all(
                color: Colors.white,
                width: 10,
              ),
              image: const DecorationImage(
                image: AssetImage('assets/png/upload_verification.jpg'),
              ),
            ),
          ),
          Spacers.listItemSpacers(),
          Text(
            "Please enter your title to ensure it's uniqueness\nbefore proceeding.",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: CAColors.text,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 75,
          ),
          Form(
            key: widget.formKey,
            child: CATextFormField(
              enabled: !widget.isVerifying,
              initialValue: widget.initialData,
              labelText: "Capstone Title",
              minLine: 3,
              onChange: widget.onChange,
              validator: widget.validator,
            ),
          ),
        ],
      ),
    );
  }
}
