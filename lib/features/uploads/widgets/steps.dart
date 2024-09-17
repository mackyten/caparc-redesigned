// import 'package:caparc/common/widgets/text_form_field.dart';
// import 'package:caparc/common/models/project_model.dart';
// import 'package:caparc/features/uploads/widgets/review.dart';
// import 'package:caparc/features/uploads/widgets/form_upload_details.dart';
// import 'package:flutter/material.dart';
// import 'package:ming_cute_icons/ming_cute_icons.dart';

// class UploadsSteps {
//   static Step step1({
//     required GlobalKey<FormState> formKey,
//     required int currentStep,
//     required bool isVerifying,
//     Function(String?)? onChange,
//     String? Function(String?)? validator,
//     String? initialData,
//   }) {
//     return Step(
//       isActive: currentStep == 0,
//       title: Container(color: Colors.amber, child: Text("Title Verification")),
//       content: Form(
//         key: formKey,
//         child: SizedBox(
//           child: CATextFormField(
//             initialValue: initialData,
//             enabled: !isVerifying,
//             labelText: "Capstone Title",
//             onChange: onChange,
//             prefix: const Icon(
//               MingCuteIcons.mgc_book_6_line,
//             ),
//             validator: validator,
//           ),
//         ),
//       ),
//     );
//   }

//   static Step step2({
//     required bool isActive,
//     required ProjectModel data,
//     required Function(ProjectModel) onChanged,
//     required GlobalKey<FormState> formKey,
//   }) {
//     return Step(
//         isActive: isActive,
//         title: Text("Details"),
//         content: UploadDetailsForm(
//           initialData: data,
//           onChanged: onChanged,
//           formKey: formKey,
//         ));
//   }

//   static Step step3({
//     required bool isActive,
//     required ProjectModel item,
//     required double bottomNavBarHeight,
//   }) {
//     return Step(
//       isActive: isActive,
//       title: Text("Review"),
//       content: Review(item: item, bottomNavBarHeight: bottomNavBarHeight),
//     );
//   }
// }
