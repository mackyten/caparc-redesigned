import 'package:caparc/blocs/upload_bloc/event.dart';
import 'package:caparc/blocs/upload_bloc/state.dart';
import 'package:caparc/common/models/project_model.dart';
import 'package:caparc/services/firebase_queries.dart';
import 'package:caparc/services/firestore_service/create_service.dart';
import 'package:caparc/services/storage_service/create_service.dart';
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
        StorageCreateServiceInterface createService =
            StorageCreateService(fileName: state.data.pickedFile!.name);

        uploadedFileUrl = await createService
            .uploadCapstoneFile(state.data.pickedFile!.path!);

        newState.data.file = uploadedFileUrl;
      }

      FirestoreCreateServiceInterface firestoreService =
          FirestoreCreateService();

      final ProjectModel result = await firestoreService.create(newState.data);
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
    project.course = event.courseModel;

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
