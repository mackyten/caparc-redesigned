import 'package:caparc/blocs/favorites_bloc/event.dart';
import 'package:caparc/blocs/favorites_bloc/state.dart';
import 'package:caparc/data/models/project_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void _onGet(GetFavorites event, Emitter<FavoriteState> emit) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("capstone-projects");

    final querySnapshot = await collectionReference
        .where('favoriteBy', arrayContains: event.currentUser.id)
        .get();

    List<ProjectModel> projects = querySnapshot.docs
        .map((e) => ProjectModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();

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
