import 'package:caparc/blocs/bottom_nav_bar_bloc/event.dart';
import 'package:caparc/blocs/bottom_nav_bar_bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(BottomNavState(selected: 0)) {
    on<SelectItem>((event, emit) {
      // Cast event to SelectItem and emit new state with updated selected value
      return emit(BottomNavState(selected: event.selected));
    });
  }

  int getSelected() {
    return state.selected;
  }
}
