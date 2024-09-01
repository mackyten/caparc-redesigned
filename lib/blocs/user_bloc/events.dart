import 'package:caparc/blocs/user_bloc/state.dart';
import 'package:flutter/material.dart';

@immutable
sealed class UserEvents {}

class SetUser extends UserEvents {
  final UserState? userState;

  SetUser({required this.userState});
}

class Logout extends UserEvents {}
