import 'package:caparc/common/models/project_model.dart';
import 'package:caparc/common/models/user_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class FavoriteState {
  final UserModel? currentUser;
  final List<ProjectModel> favorites;
  final bool isLoading;

  const FavoriteState(
      {required this.currentUser,
      required this.favorites,
      required this.isLoading});

  FavoriteState copyWith({
    UserModel? currentUser,
    List<ProjectModel>? favorites,
    bool? isLoading,
  }) {
    return FavoriteState(
        currentUser: currentUser ?? this.currentUser,
        favorites: favorites ?? this.favorites,
        isLoading: isLoading ?? this.isLoading);
  }
}
