import 'package:caparc/common/values.dart';
import 'package:caparc/common/widgets/spacers.dart';
import 'package:caparc/data/models/project_model.dart';
import 'package:caparc/presentation/ca_colors.dart';
import 'package:caparc/services/storage_service/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

class ProjectPreviewScreen extends StatefulWidget {
  final ProjectModel project;
  const ProjectPreviewScreen({
    super.key,
    required this.project,
  });

  @override
  State<ProjectPreviewScreen> createState() => _ProjectPreviewScreenState();
}

class _ProjectPreviewScreenState extends State<ProjectPreviewScreen> {
  final fileService = FileService();
  late Size screenSize;

  @override
  void didChangeDependencies() {
    screenSize = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              //height: screenSize.height - 20,
              constraints: BoxConstraints(
                minHeight: screenSize.height - 20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, -2),
                    spreadRadius: 3,
                    blurRadius: 7,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(
                  10.0,
                ),
                child: Column(
                  children: [
                    if (widget.project.file != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        margin: const EdgeInsets.only(top: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: CAColors.appBG,
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                          border: Border.all(
                            color: CAColors.success,
                          ),
                        ),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  MingCuteIcons.mgc_pdf_line,
                                  color: CAColors.secondary,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "PDF File is available for offline viewing.",
                                  style: hintStyle,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Material(
                                  color: Colors.transparent,
                                  child: Tooltip(
                                    message: "View file",
                                    child: InkWell(
                                      onTap: () {},
                                      borderRadius: BorderRadius.circular(100),
                                      child: const Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Icon(
                                          MingCuteIcons.mgc_eye_fill,
                                          color: CAColors.accent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: Tooltip(
                                    message: "Download for offline viewing",
                                    child: InkWell(
                                      onTap: _download,
                                      borderRadius: BorderRadius.circular(100),
                                      child: const Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Icon(
                                          MingCuteIcons.mgc_download_3_fill,
                                          color: CAColors.accent,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    Spacers.formFieldSpacers(),
                    container(Container(
                      padding: const EdgeInsets.only(
                        bottom: 100,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.project.title ?? "",
                            textAlign: TextAlign.center,
                            style: titleStyle,
                          ),
                          Spacers.formFieldSpacers(),
                          ...List.generate(
                              widget.project.authorAccounts!.length, (index) {
                            final author =
                                widget.project.authorAccounts![index];
                            return Text(
                              author.getFullName(),
                            );
                          }),
                        ],
                      ),
                    )),
                    container(Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Abstract:"),
                        Spacers.formFieldSpacers(),
                        Text(widget.project.projectAbstract ?? ""),
                      ],
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget container(Widget child) {
    return Container(
      height: screenSize.longestSide - 156,
      width: screenSize.shortestSide,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [paperShadow],
      ),
      child: child,
    );
  }

  Future<void> _download() async {
    if (widget.project.file == null) return;
    fileService.downloadFile(widget.project.file!, widget.project.title!);
  }
}
