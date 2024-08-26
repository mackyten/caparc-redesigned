import 'package:caparc/blocs/favorites_bloc/bloc.dart';
import 'package:caparc/blocs/favorites_bloc/event.dart';
import 'package:caparc/blocs/favorites_bloc/state.dart';
import 'package:caparc/blocs/user_bloc/bloc.dart';
import 'package:caparc/blocs/user_bloc/state.dart';
import 'package:caparc/common/widgets/favorite_item.dart';
import 'package:caparc/data/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late UserState currentUser;
  late FavoriteBloc favoriteBloc = BlocProvider.of<FavoriteBloc>(context);

  @override
  void initState() {
    currentUser = context.read<UserBloc>().state!;
    favoriteBloc.add(GetFavorites(currentUser.toUserModel()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          final myFaves = state.favorites;
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          return SizedBox(
            child: ListView.builder(
                itemCount: myFaves.length,
                itemBuilder: (_, i) {
                  final project = myFaves[i];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      20,
                      20,
                      0,
                    ),
                    child: FavoriteItem(
                      project: project,
                      currentUser: currentUser,
                      onLikeTap: _onTap,
                    ),
                  );
                }),
          );
        },
      ),
    );
  }

  void _onTap(ProjectModel project) {
    favoriteBloc.add(
      RemoveFavorite(
        project.id,
        currentUser.toUserModel(),
      ),
    );
  }
}
