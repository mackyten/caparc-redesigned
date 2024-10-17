import 'package:caparc/blocs/favorites_bloc/event.dart';
import 'package:caparc/blocs/favorites_bloc/state.dart';
import 'package:caparc/common/models/project_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/enums/account_status.dart';
import '../../common/models/user_model.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc()
      : super(
          const FavoriteState(
            currentUser: null,
            favorites: [],
            isLoading: true,
          ),
        ) {
    on<GetFavorites>(_onGet);
    on<RemoveFavorite>(_onRemove);
  }

  // void _onGet(GetFavorites event, Emitter<FavoriteState> emit) async {
  //   CollectionReference collectionReference =
  //       FirebaseFirestore.instance.collection("capstone-projects");

  //   final querySnapshot = await collectionReference
  //       .where('favoriteBy', arrayContains: event.currentUser.id)
  //       .get();

  //   List<ProjectModel> projects = querySnapshot.docs
  //       .map((e) => ProjectModel.fromJson(e.data() as Map<String, dynamic>))
  //       .toList();

  //   var newState = state.copyWith(favorites: projects, isLoading: false);

  //   emit(newState);
  // }

  void _onGet(GetFavorites event, Emitter<FavoriteState> emit) async {
    CollectionReference projectsRef =
        FirebaseFirestore.instance.collection("capstone-projects");
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection("users");

    // Fetch the favorite projects
    final querySnapshot = await projectsRef
        .where('favoriteBy', arrayContains: event.currentUser.id)
        .get();

    List<ProjectModel> projects =
        await Future.wait(querySnapshot.docs.map((doc) async {
      // Convert the project data to a ProjectModel
      ProjectModel project =
          ProjectModel.fromJson(doc.data() as Map<String, dynamic>);

      // Fetch author account details using the stored IDs
      List<UserModel> authorAccounts =
          await Future.wait(project.authorAccounts!.map((authorAc) async {
        final userSnapshot = await usersRef.doc(authorAc.id).get();
        if (userSnapshot.exists) {
          return UserModel.fromJson(
              userSnapshot.data() as Map<String, dynamic>);
        } else {
          // Return a placeholder user if the author account is missing
          return UserModel(
              id: authorAc.id,
              firstname: '',
              middlename: '',
              lastname: '',
              birthdate: DateTime.now(),
              idNumber: '',
              accountStatus: AccountStatus.verified,
              email: '',
              password: '');
        }
      }).toList());

      // Update the project with the full author accounts
      return project.copyWith(authorAccounts: authorAccounts);
    }).toList());

    // Emit the new state with the favorite projects and their author details
    var newState = state.copyWith(favorites: projects, isLoading: false);
    emit(newState);
  }

  void _onRemove(RemoveFavorite event, Emitter<FavoriteState> emit) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("capstone-projects");

    final docSnapshot = await collectionReference.doc(event.id).get();

    if (docSnapshot.exists) {
      final userId = event.currentUser.id;

      // Remove the userId from the favoriteBy array in Firestore
      await collectionReference.doc(event.id).update({
        'favoriteBy': FieldValue.arrayRemove([userId])
      });

      // Optionally, emit a new state with the updated favorites list if needed
      final updatedFavorites =
          state.favorites.where((project) => project.id != event.id).toList();

      emit(state.copyWith(favorites: updatedFavorites));
    }
  }
}
