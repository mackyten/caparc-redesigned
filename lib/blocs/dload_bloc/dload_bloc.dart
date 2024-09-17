import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

part 'dload_event.dart';
part 'dload_state.dart';

class DloadBloc extends Bloc<DloadEvent, DloadState> {
  DloadBloc() : super(const DloadState(items: [])) {
    on<GetDownLoads>(_onGet);
    on<DeleteFile>(_onDelete);
  }

  _onGet(GetDownLoads event, Emitter<DloadState> emit) async {
    final rootDir = await state.directory();
    final directory = Directory("${rootDir.path}/downloads");
    if (!directory.existsSync()) return;
    final files = directory.listSync();
    files.sort(
        ((a, b) => b.statSync().modified.compareTo(a.statSync().modified)));

    emit(DloadState(items: files));
  }

  _onDelete(DeleteFile event, Emitter<DloadState> emit) async {
    final file = File(event.filePath);
    final result = await file.delete();
    state.items.removeWhere((element) => element.path == result.path);
    emit(DloadState(items: List.from(state.items)));
  }
}
