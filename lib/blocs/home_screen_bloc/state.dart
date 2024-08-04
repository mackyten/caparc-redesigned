import 'package:caparc/data/models/project_model.dart';
import 'package:caparc/data/models/user_model.dart';
import 'package:flutter/material.dart';

@immutable
class HomeScreenState {
  final UserModel? currentUser;
  final List<ProjectModel> newProjects;
  final List<ProjectModel> myApprovedProjects;
  final List<ProjectModel> myPendingProjects;

  const HomeScreenState(
      {required this.currentUser,
      required this.newProjects,
      required this.myApprovedProjects,
      required this.myPendingProjects});
}
