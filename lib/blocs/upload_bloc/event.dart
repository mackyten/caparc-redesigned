import 'package:caparc/common/models/course_model.dart';
import 'package:caparc/common/models/project_model.dart';
import 'package:caparc/common/models/user_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

@immutable
sealed class UploadEvent {}

// final class Upload extends UploadEvent {
//   final bool isSubmitting;
//   final bool isVerifying;
//   final int currentStep;
//   final ProjectModel data;

//   Upload({
//     required this.isSubmitting,
//     required this.isVerifying,
//     required this.currentStep,
//     required this.data,
//   });
// }

// bool isVerifying = false;
// int currentStep = 0;
// final _step1FormKey = GlobalKey<FormState>();
// bool isSubmitting = false;

// ProjectModel data = ProjectModel(
//   id: "",
//   createdAt: DateTime.now(),
//   authorAccounts: [],
// );

final class VerifyTitle extends UploadEvent {
  final String title;
  VerifyTitle(this.title);
}

final class AddDetails extends UploadEvent {
  final DateTime approvedOn;
  final String projectAbstract;
  final PlatformFile? pickedFile;
  final CourseModel courseModel;

  AddDetails(
    this.approvedOn,
    this.projectAbstract,
    this.pickedFile,
    this.courseModel,
  );
}

final class UploadProject extends UploadEvent {
  final ProjectModel project;
  UploadProject(
    this.project,
  );
}

final class ReturnStep extends UploadEvent {
  ReturnStep();
}

final class AddAuthor extends UploadEvent {
  final UserModel author;
  AddAuthor(this.author);
}

final class SubmitProject extends UploadEvent {
  final Function(ProjectModel project)? onSuccess;
  final Function(Exception exception)? onError;
  SubmitProject({this.onSuccess, this.onError});
}
