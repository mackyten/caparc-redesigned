import 'package:caparc/blocs/home_bloc/state.dart';
import 'package:caparc/common/models/user_model.dart';
import 'package:flutter/material.dart';

@immutable
sealed class HomeScreenEvent {}

final class SetState extends HomeScreenEvent {
  final HomeScreenState state;

  SetState({required this.state});
}

final class GetProjects extends HomeScreenEvent {
  final UserModel currentUser;
  GetProjects(this.currentUser);
}
