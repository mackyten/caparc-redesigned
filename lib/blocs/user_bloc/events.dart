import 'package:caparc/blocs/user_bloc/state.dart';
import 'package:flutter/material.dart';

@immutable
sealed class UserEvents {}

class SignIn extends UserEvents {
  final UserState? userState;

  SignIn({required this.userState});
}

class Logout extends UserEvents {}
