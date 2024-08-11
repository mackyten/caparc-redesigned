import 'package:caparc/common/widgets/text_form_field.dart';
import 'package:caparc/data/models/project_model.dart';
import 'package:caparc/presentation/screens/uploads/widgets/upload_details_form.dart';
import 'package:flutter/material.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

class UploadsSteps {
  static Step step1({
    required GlobalKey<FormState> formKey,
    required int currentStep,
    required bool isVerifying,
    Function(String?)? onChange,
    String? Function(String?)? validator,
  }) {
    return Step(
      isActive: currentStep == 0,
      title: Container(color: Colors.amber, child: Text("Title Verification")),
      content: Form(
        key: formKey,
        child: SizedBox(
          child: CATextFormField(
            enabled: !isVerifying,
            labelText: "Capstone Title",
            // onChange: (val) {
            //   data.title = val;
            // },
            onChange: onChange,
            prefix: const Icon(
              MingCuteIcons.mgc_book_6_line,
            ),
            validator: validator,
            // validator: (val) {
            //   if (val == null ||
            //       data.title == null ||
            //       val.isEmpty ||
            //       data.title!.isEmpty) {
            //     return "Please enter your title.";
            //   }
            //   return null;
            // },
          ),
        ),
      ),
    );
  }

  static Step step2({
    required bool isActive,
    required ProjectModel data,
    required Function(ProjectModel) onChanged,
  }) {
    return Step(
        isActive: isActive,
        title: Text("Details"),
        content: UploadDetailsForm(
          initialData: data,
          onChanged: onChanged,
        ));
  }

  static Step step3({
    required bool isActive,
  }) {
    return Step(
        isActive: isActive, title: Text("Review"), content: Container());
  }
}
