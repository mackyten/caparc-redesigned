import 'package:caparc/blocs/user_bloc/state.dart';
import 'package:caparc/common/values.dart';
import 'package:caparc/common/models/project_model.dart';
import 'package:caparc/common/ca_colors.dart';
import 'package:caparc/features/document_preview/screen.dart';
import 'package:caparc/services/firestore_service/create_service.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class CapstoneBook extends StatelessWidget {
  final Size screenSize;
  final ProjectModel project;
  final UserState currentUser;
  const CapstoneBook(
      {super.key,
      required this.screenSize,
      required this.project,
      required this.currentUser});

  @override
  Widget build(BuildContext context) {
    FirestoreCreateServiceInterface firestoreService = FirestoreCreateService();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _onTap(context),
        child: Container(
          margin: EdgeInsets.all(insidePadding),
          height: 280,
          width: 200,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 24, 53, 99),
              borderRadius: BorderRadius.circular(3),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 24, 53, 99),
                    offset: Offset(7, 7)),
                BoxShadow(
                    color: Color.fromARGB(255, 224, 220, 220),
                    offset: Offset(5, 5)),
              ]),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 3,
                color: CAColors.accent,
                height: 250,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(6, 6, 0, 6),
                width: 174,
                height: 280,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 168,
                      child: Text(
                        project.title ?? "<Untitled>",
                        style: TextStyle(
                            color: Colors.amber.shade600,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Times',
                            overflow: TextOverflow.ellipsis),
                        maxLines: 8,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                      '${project.viewedBy?.length ?? 0} Views | ${project.downloadedBy?.length ?? 0} Downloads',
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    const Spacer(),
                    if (project.id.isNotEmpty)
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 23,
                          width: 23,

                          // width: double.infinity,

                          child: LikeButton(
                            isLiked: project.favoriteBy
                                    ?.map((e) => e.id)
                                    .toList()
                                    .contains(currentUser.id) ??
                                false,
                            size: 20,
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            onTap: (isLiked) async {
                              final result = await firestoreService.toggleLike(
                                  project.id, currentUser.id);
                              return result;
                            },
                          ),
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
    // return Container(
    //   height: 280,
    //   width: screenSize.width,
    //   child: ListView.builder(
    //       scrollDirection: Axis.horizontal,
    //       itemCount: 10,
    //       itemBuilder: (_, i) {

    //       }),
    // );
  }

  void _onTap(context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ProjectPreviewScreen(project: project)));
  }
}
