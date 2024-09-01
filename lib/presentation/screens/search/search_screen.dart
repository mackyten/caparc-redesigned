import 'package:caparc/blocs/favorites_bloc/bloc.dart';
import 'package:caparc/blocs/favorites_bloc/event.dart';
import 'package:caparc/blocs/search_bloc/search_bloc.dart';
import 'package:caparc/blocs/user_bloc/bloc.dart';
import 'package:caparc/blocs/user_bloc/state.dart';
import 'package:caparc/common/values.dart';
import 'package:caparc/common/widgets/favorite_item.dart';
import 'package:caparc/common/widgets/spacers.dart';
import 'package:caparc/common/widgets/text_form_field.dart';
import 'package:caparc/data/models/project_model.dart';
import 'package:caparc/data/models/user_model.dart';
import 'package:caparc/presentation/screens/document_preview/screen.dart';
import 'package:caparc/services/firestore_service/create_service.dart';
import 'package:caparc/services/firestore_service/firestore_service.dart';
import 'package:caparc/services/firestore_service/query_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FirestoreQueryInterface iFirestoreService = FirestoreQuery();
  late final SearchBloc searchBloc = context.read<SearchBloc>();
  late final UserState? currentUser = context.read<UserBloc>().state;
  late final FavoriteBloc favoriteBloc = context.read<FavoriteBloc>();
  //String query = '';

  @override
  void initState() {
    searchBloc.add(
      SearchTitle(title: searchBloc.state.query ?? ""),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SearchBloc, SearchBlocState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: bodyPadding),
              child: Column(
                children: [
                  Spacers.formFieldSpacers(),
                  CATextFormField(
                    initialValue: state.query,
                    hintText: "Search for title",
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.search,
                    prefix: const Icon(
                      MingCuteIcons.mgc_search_2_fill,
                    ),
                    onFieldSubmitted: (val) async {
                      // final x =
                      //     await iFirestoreService.getDocumentsByTitle(val);
                      searchBloc.add(SearchTitle(title: val));

                      // print("RESULT: ${x.length}");
                    },
                  ),
                  Spacers.formFieldSpacers(),
                  if (state.loading) const CircularProgressIndicator.adaptive(),
                  if (!state.loading)
                    ...List.generate(
                      state.projects.length,
                      (index) {
                        final project = state.projects[index];
                        return FavoriteItem(
                          project: project,
                          currentUser: currentUser!,
                          onTap: _ontap,
                          onLikeTap: (val) =>
                              _onLikeTap(val, state.query ?? ""),
                        );
                      },
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _ontap(ProjectModel project) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProjectPreviewScreen(project: project),
      ),
    );
  }

  void _onLikeTap(ProjectModel project, String query) async {
    FirestoreCreateServiceInterface iCreatService = FirestoreCreateService();
    final result = await iCreatService.toggleLike(project.id, currentUser!.id);
    searchBloc.add(
      SearchTitle(title: query),
    );
    // favoriteBloc.add(
    //   RemoveFavorite(
    //     project.id,
    //     currentUser!.toUserModel(),
    //   ),
    // );
  }
}
