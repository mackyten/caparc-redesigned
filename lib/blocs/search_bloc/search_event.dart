part of 'search_bloc.dart';

@immutable
sealed class SearchBlocEvent {}

class SearchTitle extends SearchBlocEvent {
  final String title;
  SearchTitle({required this.title});
}
