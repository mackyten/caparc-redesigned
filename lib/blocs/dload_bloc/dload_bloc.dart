import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

part 'dload_event.dart';
part 'dload_state.dart';

class DloadBloc extends Bloc<DloadEvent, DloadState> {
  DloadBloc() : super(const DloadState(items: [])) {
    on<DloadEvent>(_onGet);
  }

  _onGet(DloadEvent event, Emitter<DloadState> emit) async {
    final directory = await state.directory();
    final files = Directory("${directory.path}/downloads").listSync();
    files.sort(
        ((a, b) => b.statSync().modified.compareTo(a.statSync().modified)));

    emit(DloadState(items: files));
  }
}
