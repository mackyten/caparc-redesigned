import 'dart:io';
import 'package:caparc/common/enums/file_size_unit.dart';
import 'package:caparc/common/methods/file_size_builder.dart';
import 'package:caparc/common/values.dart';
import 'package:caparc/common/widgets/pdf_viewer.dart';
import 'package:caparc/common/widgets/spacers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

class DownloadedItem extends StatelessWidget {
  final FileSystemEntity item;

  const DownloadedItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    DateTime dateModified = item.statSync().modified;
    String title = item.path.split('/').last;
    String size = FileSize.formatBytes(item.statSync().size).toLowerCase();

    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          bottom: bodyPadding,
          left: bodyPadding,
          right: bodyPadding,
        ),
        constraints: const BoxConstraints(
          minHeight: 80,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            paperShadow,
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            onTap: () => _ontap(context, item.path),
            child: Padding(
              padding: EdgeInsets.all(
                insidePadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        // width: 60,
                        height: 60,
                        child: const Center(
                          child: Icon(
                            MingCuteIcons.mgc_pdf_fill,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          title,
                          style: subtitleStyle,
                        ),
                      )
                    ],
                  ),
                  Spacers.listItemSpacers(),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          DateFormat("MMM dd, yyyy  h:mm a")
                              .format(dateModified),
                          style: hintStyle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          size,
                          style: hintStyle,
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _ontap(BuildContext context, String path) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CAPDFViewer(path: path),
      ),
    );
  }
}
