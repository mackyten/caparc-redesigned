part of 'profile_bloc.dart';

@immutable
class ProfileBlocState {
  final bool isEditting;
  final bool isSubmitting;

  const ProfileBlocState({
    this.isEditting = false,
    this.isSubmitting = false,
  });

  ProfileBlocState copyWith({
    bool? isEditting,
    bool? isSubmitting,
  }) {
    return ProfileBlocState(
      isEditting: isEditting ?? this.isEditting,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  ProfileBlocState initial() {
    return const ProfileBlocState(isEditting: false, isSubmitting: false);
  }
}
