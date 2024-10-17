import 'package:caparc/blocs/user_bloc/state.dart';
import 'package:caparc/common/ca_colors.dart';
import 'package:caparc/common/values.dart';
import 'package:caparc/common/models/project_model.dart';
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
    TextTheme textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onTap != null ? onTap!(project) : null,
        child: LayoutBuilder(builder: (_, constraints) {
          return Container(
            padding: const EdgeInsets.all(12.0),
            constraints: const BoxConstraints(minHeight: 120),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: defaultBoxShadow,
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: CAColors.primary,
                        border: Border.all(
                          color: Colors.amber,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(60),
                      ),
                      child: Center(
                        child: Text(
                          project.course?.code ?? "N/A",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.25),
                                  offset: const Offset(0, 4),
                                  blurRadius: 7,
                                )
                              ]),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Container(
                      child: Text(
                        project.title ?? "<Untitled>",
                        style: textTheme.titleMedium,
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
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${project.authors()} (${project.approvedOn?.year})",
                  style: textTheme.bodySmall,
                ),
                Text(
                  "${project.viewedBy?.length ?? 0} View${(project.viewedBy?.length ?? 0) > 1 ? "s" : ""} | "
                  "${project.downloadedBy?.length ?? 0} Download${(project.downloadedBy?.length ?? 0) > 1 ? "s" : ""}",
                  style: textTheme.bodySmall,
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
