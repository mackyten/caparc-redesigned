part of 'profile_bloc.dart';

@immutable
sealed class ProfileBlocEvent {}

class SetEdit extends ProfileBlocEvent {}

class Submit extends ProfileBlocEvent {
  final UserModel data;
  final UserBloc userBloc;
  final VoidCallback onSuccessfulUpdate;

  Submit({
    required this.data,
    required this.userBloc,
    required this.onSuccessfulUpdate,
  });
}

class ResetState extends ProfileBlocEvent {}
