import 'package:caparc/blocs/user_bloc/state.dart';
import 'package:caparc/common/values.dart';
import 'package:caparc/data/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class FavoriteItem extends StatelessWidget {
  final ProjectModel project;
  final UserState currentUser;
  final Function(ProjectModel project)? onLikeTap;
  final Function(ProjectModel project)? onTap;

  const FavoriteItem(
      {super.key,
      required this.project,
      required this.currentUser,
      this.onLikeTap,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap != null ? onTap!(project) : null,
        child: LayoutBuilder(builder: (_, constraints) {
          return Container(
            padding: EdgeInsets.all(16.0),
            constraints: BoxConstraints(minHeight: 120),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: defaultBoxShadow,
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  //TODO: Add course abbrev.
                  child: Center(
                    child: Text(
                      "COURSE",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                  color: Colors.amber,
                  child: Text(
                    project.title ?? "<Untitled>",
                    style: titleStyle,
                  ),
                )),
                const SizedBox(
                  width: 10,
                ),
                Align(
                  child: LikeButton(
                    isLiked: project.favoriteBy
                            ?.map((e) => e.id)
                            .toList()
                            .contains(currentUser.id) ??
                        false,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    onTap: (isLiked) async {
                      // final result = await HomeService.toggleLike(
                      //     project.id, currentUser.id);
                      if (onLikeTap != null) onLikeTap!(project);

                      return !isLiked;
                    },
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
