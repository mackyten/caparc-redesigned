import 'package:caparc/blocs/home_bloc/event.dart';
import 'package:caparc/blocs/home_bloc/state.dart';
import 'package:caparc/common/models/project_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc()
      : super(const HomeScreenState(
            currentUser: null,
            newProjects: [],
            myApprovedProjects: [],
            myPendingProjects: [])) {
    on<SetState>((event, emit) => emit(event.state));
    on<GetProjects>(_onGet);
  }

  void _onGet(GetProjects event, Emitter<HomeScreenState> emit) async {
    try {
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection("capstone-projects");
      final QuerySnapshot snapshot =
          await collectionReference.orderBy('createdAt').limit(5).get();
      List<ProjectModel> projects = snapshot.docs
          .map((e) => ProjectModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      var newState = state.copyWith(
          newProjects: projects
              .where(
                (ProjectModel element) => element.isAccepted == true,
              )
              .toList(),
          myApprovedProjects: projects
              .where(
                (ProjectModel element) =>
                    element.authorAccounts!
                        .map((e) => e.id)
                        .toList()
                        .contains(event.currentUser.id) &&
                    element.isAccepted == true,
              )
              .toList(),
          myPendingProjects: projects
              .where(
                (ProjectModel element) =>
                    element.authorAccounts!
                        .map((e) => e.id)
                        .toList()
                        .contains(event.currentUser.id) &&
                    element.isAccepted == null,
              )
              .toList());

      emit(newState);
    } on FirebaseException catch (e) {
      print(e.message);
      rethrow;
    }
  }
}
