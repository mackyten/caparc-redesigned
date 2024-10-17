import 'package:caparc/common/ca_colors.dart';
import 'package:caparc/common/models/project_model.dart';
import 'package:caparc/common/values.dart';
import 'package:caparc/common/widgets/course_picker/course_picker.dart';
import 'package:caparc/common/widgets/date_form_field.dart';
import 'package:caparc/common/widgets/file_picker.dart';
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
                // CAFormField.textField(
                //   labelText: "Capstone Title",

                // ),
                TextFormField(
                  enabled: false,
                  initialValue: data.title,
                  decoration: const InputDecoration(
                    label: Text("Capstone Title,"),
                  ),
                ),
                Spacers.formFieldSpacers(),

                CADateFormField(
                  label: 'Date Approved',
                  onPicked: (val) {
                    setState(() {
                      data.approvedOn = val;
                    });
                    widget.onChanged(data);
                  },
                  initialValue: data.approvedOn,
                  validator: (value) {
                    if (data.approvedOn == null) {
                      return "Please enter when your capstone was approved.";
                    }
                    return null;
                  },
                ),
                Spacers.formFieldSpacers(),
                CoursePicker(
                    initialValue: data.course,
                    validator: (val) {
                      return val == null || val.isEmpty
                          ? "Please enter your course / program."
                          : null;
                    },
                    onItemPicked: (course) {
                      setState(() {
                        data.course = course;
                      });
                      widget.onChanged(data);
                    }),
                Spacers.formFieldSpacers(),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Abstract",
                  ),
                  initialValue: data.projectAbstract,
                  minLines: 4,
                  maxLines: 10,
                  validator: (value) {
                    if (data.projectAbstract == null ||
                        data.projectAbstract!.isEmpty) {
                      return "Please enter couple of lines of your project's abstract.";
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      data.projectAbstract = val;
                    });
                    widget.onChanged(data);
                  },
                ),
                Spacers.formFieldSpacers(),
                CAFilePicker(
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
