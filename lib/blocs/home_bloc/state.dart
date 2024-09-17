import 'package:caparc/common/models/project_model.dart';
import 'package:caparc/common/models/user_model.dart';
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

  HomeScreenState copyWith({
    UserModel? currentUser,
    List<ProjectModel>? newProjects,
    List<ProjectModel>? myApprovedProjects,
    List<ProjectModel>? myPendingProjects,
  }) {
    return HomeScreenState(
      currentUser: currentUser ?? this.currentUser,
      newProjects: newProjects ?? this.newProjects,
      myApprovedProjects: myApprovedProjects ?? this.myApprovedProjects,
      myPendingProjects: myPendingProjects ?? this.myPendingProjects,
    );
  }
}
