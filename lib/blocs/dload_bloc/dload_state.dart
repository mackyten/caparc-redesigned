part of 'dload_bloc.dart';

@immutable
class DloadState {
  Future<Directory> directory() async {
    final directory = await getApplicationCacheDirectory();
    return directory;
  }

  final List<FileSystemEntity> items;
  const DloadState({required this.items});

  DloadState copyWith({List<FileSystemEntity>? items}) {
    return DloadState(items: items ?? this.items);
  }
}