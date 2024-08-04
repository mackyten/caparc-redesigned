import 'package:caparc/blocs/home_screen_bloc/event.dart';
import 'package:caparc/blocs/home_screen_bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc()
      : super(const HomeScreenState(
            currentUser: null,
            newProjects: [],
            myApprovedProjects: [],
            myPendingProjects: [])) {
    on<SetState>((event, emit) => emit(event.state));
  }
}
