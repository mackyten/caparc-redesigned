part of 'dload_bloc.dart';

@immutable
sealed class DloadEvent {}

final class GetDownLoads extends DloadEvent {}

final class DeleteFile extends DloadEvent {
  final String filePath;
  DeleteFile({required this.filePath});
}
