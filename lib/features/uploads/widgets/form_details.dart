import 'package:caparc/common/ca_colors.dart';
import 'package:caparc/common/models/project_model.dart';
import 'package:caparc/common/values.dart';
import 'package:caparc/common/widgets/date_form_field.dart';
import 'package:caparc/common/widgets/spacers.dart';
import 'package:caparc/common/widgets/text_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(ProjectModel updatedData) onChanged;
  final ProjectModel data;
  const DetailsForm({
    super.key,
    required this.formKey,
    required this.data,
    required this.onChanged,
  });

  @override
  State<DetailsForm> createState() => _DetailsFormState();
}

class _DetailsFormState extends State<DetailsForm> {
  late ProjectModel data = widget.data.copyWith();
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
                width: 10,
                color: Colors.white,
              ),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/png/upload_details.jpg'),
              ),
            ),
          ),
          Spacers.listItemSpacers(),
          Text(
            "Complete the form by entering the rest of the\ncapstone details.",
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
            child: Column(
              children: [
                CAFormField.textField(
                  labelText: "Capstone Title",
                  enabled: false,
                  initialValue: data.title,
                ),
                Spacers.formFieldSpacers(),
                CAFormField.dateField(
                  labelText: "Date Approved",
                  onDateChanged: (val) {
                    setState(() {
                      data.approvedOn = val;
                    });
                    widget.onChanged(data);
                  },
                  initialValue: data.approvedOn,
                  validator: (value) {
                    if (data.title == null || data.title!.isEmpty) {
                      return "Please enter when your capstone was approved.";
                    }
                    return null;
                  },
                ),
                Spacers.formFieldSpacers(),
                CAFormField.textField(
                  labelText: "Abstract",
                  initialValue: data.projectAbstract,
                  minLine: 4,
                  validator: (value) {
                    if (data.projectAbstract == null ||
                        data.projectAbstract!.isEmpty) {
                      return "Please enter couple of lines of your project's abstract.";
                    }
                    return null;
                  },
                  onChange: (val) {
                    setState(() {
                      data.projectAbstract = val;
                    });
                    widget.onChanged(data);
                  },
                ),
                Spacers.formFieldSpacers(),
                CAFormField.filePickerField(
                  onPicked: (file) {
                    setState(() {
                      data.pickedFile = file;
                    });
                    widget.onChanged(data);
                  },
                  initialValue:
                      data.pickedFile?.name ?? "Attach your PDF file here",
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
