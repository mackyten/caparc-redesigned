import 'package:caparc/data/models/project_model.dart';
import 'package:caparc/services/firestore_service/query_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  SearchBloc()
      : super(const SearchBlocState(
          projects: [],
          query: '',
          loading: true,
        )) {
    on<SearchTitle>(_onSearch);
  }

  Future<void> _onSearch(
      SearchTitle event, Emitter<SearchBlocState> emit) async {
    emit(state.copyWith(loading: true));
    FirestoreQueryInterface iFirestoreService = FirestoreQuery();

    final List<ProjectModel> result =
        await iFirestoreService.getDocumentsByTitle(event.title);

    final newState = state.copyWith(
      query: event.title,
      projects: result,
      loading: false,
    );

    emit(newState);
  }
}
