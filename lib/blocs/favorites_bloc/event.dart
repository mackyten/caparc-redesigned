import 'package:caparc/data/models/user_model.dart';
import 'package:flutter/foundation.dart';

@immutable
sealed class FavoriteEvent {}

final class GetFavorites extends FavoriteEvent {
  final UserModel currentUser;
  GetFavorites(this.currentUser);
}

final class RemoveFavorite extends FavoriteEvent {
  final String id;
  final UserModel currentUser;
  RemoveFavorite(this.id, this.currentUser);
}
