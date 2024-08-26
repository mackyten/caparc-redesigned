import 'dart:io';

import 'package:caparc/blocs/upload_screen_bloc/event.dart';
import 'package:caparc/blocs/upload_screen_bloc/state.dart';
import 'package:caparc/blocs/user_bloc/bloc.dart';
import 'package:caparc/blocs/user_bloc/state.dart';
import 'package:caparc/data/models/project_model.dart';
import 'package:caparc/data/models/user_model.dart';
import 'package:caparc/services/file_service/file_service.dart';
import 'package:caparc/services/firebase_queries.dart';
import 'package:caparc/services/upload_service/upload_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  UploadBloc() : super(UploadState.initial().copyWith()) {
    on<VerifyTitle>(_verifyTitle);
    on<ReturnStep>(_returnStep);
    on<AddAuthor>(_addAuthor);
    on<AddDetails>(_onAddDetails);
    on<SubmitProject>(_onSubmit);
  }

  void _onSubmit(SubmitProject event, Emitter<UploadState> emit) async {
    final newState = state.copyWith();
    newState.isSubmitting = true;
    emit(newState);
    try {
      String? uploadedFileUrl;

      if (state.data.pickedFile != null) {
        final fileService = FileService();
        uploadedFileUrl = await fileService.uploadFile(
            state.data.title ?? "random", state.data.pickedFile!.path!);
        newState.data.file = uploadedFileUrl;
        // print("UPLOADING THE FILE....");
        // final storageRef = FirebaseStorage.instance
        //     .ref()
        //     .child('capstone-files/${state.data.pickedFile!.name}');
        // final uploadTask =
        //     storageRef.putFile(File(state.data.pickedFile!.path!));
        // final snapShot = await uploadTask
        //     .whenComplete(() => print("FILE UPLOADED"))
        //     .catchError((e) {
        //   print("CATCHED ERROR: ${e}");
        // });
        // uploadedFileUrl = await snapShot.ref.getDownloadURL();
        // newState.data.file = uploadedFileUrl;
        // print(uploadedFileUrl);
      }

      final ProjectModel result = await UploadService.create(newState.data);
      if (result.id.isNotEmpty) {
        emit(UploadState.initial());
        if (event.onSuccess != null) {
          event.onSuccess!(result);
        }
      }
    } catch (e) {
      if (event.onError != null) {
        event.onError!(Exception(e));
      }
    }
  }

  void _onAddDetails(AddDetails event, Emitter<UploadState> emit) {
    var project = state.data.copyWith();
    project.approvedOn = event.approvedOn;
    project.projectAbstract = event.projectAbstract;
    project.pickedFile = event.pickedFile;

    emit(
      state.copyWith(data: project, currentStep: state.currentStep + 1),
    );
  }

  void _returnStep(ReturnStep event, Emitter<UploadState> emit) async {
    if (state.currentStep > 0 && !state.isSubmitting) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  void _addAuthor(AddAuthor event, Emitter<UploadState> emit) {
    if (!state.data.authorAccounts!
        .map((e) => e.id)
        .contains(event.author.id)) {
      var project = state.data.copyWith();
      project.authorAccounts!.add(event.author);

      emit(
        state.copyWith(data: project),
      );
    }
  }

  Future<void> _verifyTitle(
      VerifyTitle event, Emitter<UploadState> emit) async {
    // Emit the new state with isVerifying set to true

    emit(state.copyWith(isVerifying: true));

    // Perform the title check
    final bool isExisting =
        await FirebaseQueries.checkTitleIfExists(event.title);

    if (isExisting) {
      // TODO: Handle the case where the title already exists

      emit(state.copyWith(isVerifying: false)); // Reset isVerifying
      return;
    }

    // Simulate delay and update the current step
    await Future.delayed(const Duration(seconds: 2));

    // Emit the new state with the updated currentStep and reset isVerifying

    ProjectModel project = state.data.copyWith();
    project.title = event.title;
    emit(
      state.copyWith(
        isVerifying: false,
        currentStep: state.currentStep + 1,
        data: project,
      ),
    );
  }
}
