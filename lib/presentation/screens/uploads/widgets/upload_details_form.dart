import 'package:caparc/common/widgets/date_form_field.dart';
import 'package:caparc/common/widgets/spacers.dart';
import 'package:caparc/common/widgets/text_form_field.dart';
import 'package:caparc/data/models/project_model.dart';
import 'package:caparc/presentation/ca_colors.dart';
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
      setState(() {
        data = widget.initialData;
      });
      print("FORM UPDATED");
    }
    print("ASSASA");
    super.didUpdateWidget(oldWidget);
  }

// @override
//   void didUpdateWidget(covariant UploadDetailsForm oldWidget) {
//    if(oldWidget.initialData.title != widget.initialData.title)
//    {
//     print("TITLE CHANGED");
//     setState(() {
//       data.title = widget.initialData.title;
//     });
//    }
//     super.didUpdateWidget(oldWidget);
//   }
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

                // CATextFormField(
                //   labelText: "Title",
                //   prefix: const Icon(
                //     MingCuteIcons.mgc_book_6_line,
                //   ),
                //   initialValue: "asdajsh",
                //   enabled: false,
                // ),

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

                Spacers.formFieldSpacers()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
