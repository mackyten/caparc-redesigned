part of 'dload_bloc.dart';

@immutable
sealed class DloadEvent {}

final class GetDownLoads extends DloadEvent {}
