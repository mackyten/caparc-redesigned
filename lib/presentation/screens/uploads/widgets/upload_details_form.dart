import 'package:caparc/common/widgets/date_form_field.dart';
import 'package:caparc/common/widgets/spacers.dart';
import 'package:caparc/common/widgets/text_form_field.dart';
import 'package:caparc/data/models/project_model.dart';
import 'package:caparc/presentation/ca_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadDetailsForm extends StatefulWidget {
  final ProjectModel initialData;
  final GlobalKey<FormState> formKey;
  final Function(ProjectModel) onChanged;

  const UploadDetailsForm({
    super.key,
    required this.initialData,
    required this.onChanged,
    required this.formKey,
  });

  @override
  State<UploadDetailsForm> createState() => _UploadDetailsFormState();
}

class _UploadDetailsFormState extends State<UploadDetailsForm> {
  late ProjectModel data;

  @override
  void initState() {
    data = widget.initialData;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant UploadDetailsForm oldWidget) {
    if (widget.initialData != oldWidget.initialData) {
      if (mounted) {
        setState(() {
          data = widget.initialData;
        });
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: widget.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: CAColors.accent,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                    children: [
                      const TextSpan(
                        text: "Title: ",
                      ),
                      TextSpan(
                        text: data.title ?? "<TITLE IS MISSING>",
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: CAColors.accent,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                    children: [
                      const TextSpan(
                        text: "Authors: ",
                      ),
                      ...List.generate(data.authorAccounts?.length ?? 0,
                          (index) {
                        final author = data.authorAccounts![index];
                        return TextSpan(
                          text:
                              "${author.getFullName()} ${author != data.authorAccounts!.last ? ", " : ""}",
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        );
                      })
                    ],
                  ),
                ),

                Spacers.formFieldSpacers(),

                //TODO: Make Month Picker only
                CADateFormField(
                  label: "Date Approved",
                  initialValue: data.approvedOn,
                  onPicked: (DateTime val) {
                    data.approvedOn = val;
                    widget.onChanged(data);
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty || data.approvedOn == null) {
                      return "This field is required";
                    }
                    return null;
                  },
                ),

                //TODO: Make Searcheable for Users
                Spacers.formFieldSpacers(),
                CATextFormField(
                  labelText: "Abstract",
                  initialValue: data.projectAbstract,
                  minLine: 5,
                  onChange: (val) {
                    data.projectAbstract = val;
                    widget.onChanged(data);
                  },
                  validator: (val) {
                    if (val == null ||
                        val.isEmpty ||
                        data.projectAbstract == null) {
                      return "This field is required";
                    }
                    return null;
                  },
                ),

                Spacers.formFieldSpacers(),
                InkWell(
                  onTap: pickFile,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: CAColors.accent,
                      ),
                    ),
                    child: Text(
                      data.pickedFile != null
                          ? "${data.pickedFile?.name}"
                          : "Attach file",
                    ),
                  ),
                ),

                Spacers.formFieldSpacers()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (result != null) {
      // File file = File(result.files.single.path!);
      if (mounted) {
        setState(() {
          data.pickedFile = result.files.first;
        });
      }
      widget.onChanged(data);
    } else {
      // User canceled the picker
    }
  }
}
