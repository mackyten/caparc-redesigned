part of 'search_bloc.dart';

@immutable
class SearchBlocState {
  final String? query;
  final bool loading;
  final List<ProjectModel> projects;

  const SearchBlocState(
      {required this.projects, required this.query, required this.loading});

  SearchBlocState copyWith({
    String? query,
    List<ProjectModel>? projects,
    bool? loading,
  }) {
    return SearchBlocState(
      projects: projects ?? this.projects,
      query: query,
      loading: loading ?? this.loading,
    );
  }
}
