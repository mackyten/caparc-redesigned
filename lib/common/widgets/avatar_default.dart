import 'package:caparc/common/values.dart';
import 'package:caparc/presentation/ca_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

class AvatarDefault extends StatelessWidget {
  final bool isEditting;
  final String? link;
  final PlatformFile? pickedFile;
  final Function(FilePickerResult? filePickerResult)? onFilePicked;
  const AvatarDefault({
    super.key,
    this.isEditting = false,
    this.onFilePicked,
    this.link,
    this.pickedFile,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: CAColors.primary,
                    borderRadius: BorderRadius.circular(
                      constraints.maxWidth,
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                        spreadRadius: 0,
                        color: Colors.black.withOpacity(0.25),
                      )
                    ]),
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      constraints.maxWidth,
                    ),
                    image: pickedFile != null
                        ? DecorationImage(
                            image: AssetImage(pickedFile!.path!),
                            fit: BoxFit.cover,
                          )
                        : link != null
                            ? DecorationImage(
                                image: NetworkImage(link!),
                                fit: BoxFit.cover,
                              )
                            : null,
                  ),
                ),
              ),
              if (isEditting)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: _onEdit,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: CAColors.white,
                        borderRadius: BorderRadius.circular(
                          45,
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withOpacity(.25),
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: const Icon(
                        MingCuteIcons.mgc_pencil_fill,
                        color: CAColors.accent,
                      ),
                    ),
                  ),
                )
            ],
          );
        },
      ),
    );
  }

  void _onEdit() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (onFilePicked != null) {
      onFilePicked!(result);
    }
  }
}
