
import 'package:caparc/blocs/user_bloc/bloc.dart';
import 'package:caparc/blocs/user_bloc/events.dart';
import 'package:caparc/data/models/user_model.dart';
import 'package:caparc/services/firestore_service/update_service.dart';
import 'package:caparc/services/storage_service/create_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileBlocEvent, ProfileBlocState> {
  ProfileBloc()
      : super(
          const ProfileBlocState(
            isEditting: false,
            isSubmitting: false,
          ),
        ) {
    on<SetEdit>(_onSetEdit);
    on<Submit>(_onSubmit);
    on<ResetState>(_onReset);
  }

  void _onSetEdit(SetEdit event, Emitter<ProfileBlocState> emit) {
    emit(state.copyWith(isEditting: !state.isEditting));
  }

  void _onSubmit(Submit event, Emitter<ProfileBlocState> emit) async {
    final UpdateServiceInterface service = UpdateService();
    UserModel toUpdate = event.data;
    emit(state.copyWith(isSubmitting: true));

    if (event.data.pickedAvatar != null) {
      StorageCreateServiceInterface storageCreateService =
          StorageCreateService(fileName: event.data.id);
      toUpdate.avatarLink = await storageCreateService
          .uploadAvatar(event.data.pickedAvatar!.path!);
    }

    final UserModel updated = await service.updateUserProfile(toUpdate);

    event.userBloc.add(
      SetUser(
        userState: updated.toUserState(),
      ),
    );
    event.onSuccessfulUpdate();
    emit(state.copyWith(isSubmitting: false));
  }

  void _onReset(ResetState event, Emitter<ProfileBlocState> emit) {
    emit(state.initial());
  }
}
