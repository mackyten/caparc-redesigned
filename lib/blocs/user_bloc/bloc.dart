import 'package:caparc/blocs/user_bloc/events.dart';
import 'package:caparc/blocs/user_bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvents, UserState?> {
  UserBloc() : super(null) {
    on<SignIn>((event, emit) => emit(event.userState));
    on<Logout>((event, emit) => emit(null));
  }
}
