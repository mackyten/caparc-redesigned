import 'package:caparc/data/models/project_model.dart';
import 'package:flutter/material.dart';

@immutable
class UploadState {
  bool isSubmitting;
  bool isVerifying;
  int currentStep;

  ProjectModel data;

  UploadState({
    required this.isSubmitting,
    required this.isVerifying,
    required this.currentStep,
    required this.data,
  });

  UploadState copyWith({
    bool? isSubmitting,
    bool? isVerifying,
    int? currentStep,
    GlobalKey<FormState>? step1FormKey,
    GlobalKey<FormState>? step2FormKey,
    ProjectModel? data,
  }) {
    return UploadState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isVerifying: isVerifying ?? this.isVerifying,
      currentStep: currentStep ?? this.currentStep,
      data: data ?? this.data,
    );
  }

  factory UploadState.initial() {
    return UploadState(
      isSubmitting: false,
      isVerifying: false,
      currentStep: 0,
      data: ProjectModel(
        id: "",
        createdAt: DateTime.now(),
        authorAccounts: [],
      ),
    );
  }
}
