import 'package:caparc/blocs/home_screen_bloc/state.dart';
import 'package:flutter/material.dart';

@immutable
sealed class HomeScreenEvent {}

final class SetState extends HomeScreenEvent {
  final HomeScreenState state;

  SetState({required this.state});
}
