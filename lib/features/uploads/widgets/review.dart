import 'package:caparc/common/ca_colors.dart';
import 'package:caparc/common/methods/file_size_builder.dart';
import 'package:caparc/common/models/project_model.dart';
import 'package:caparc/common/values.dart';
import 'package:caparc/common/widgets/file_picker.dart';
import 'package:caparc/common/widgets/spacers.dart';
import 'package:caparc/common/widgets/text_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class UploadReview extends StatefulWidget {
  final ProjectModel data;
  const UploadReview({super.key, required this.data});

  @override
  State<UploadReview> createState() => _UploadReviewState();
}

class _UploadReviewState extends State<UploadReview> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
              border: Border.all(
                color: Colors.white,
                width: 10,
              ),
              color: Colors.white,
              boxShadow: defaultBoxShadow,
              image: const DecorationImage(
                image: AssetImage('assets/png/upload_review.jpg'),
              ),
            ),
          ),
          Spacers.listItemSpacers(),
          Text(
            "Take a moment to double-check the information to\nensure it is accurate.",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: CAColors.text,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: double.infinity,
            decoration:
                BoxDecoration(color: Colors.white, boxShadow: defaultBoxShadow),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title("Title :"),
                  body(widget.data.title ?? ""),
                  title("Authors :"),
                  ...List.generate(widget.data.authorAccounts?.length ?? 0,
                      (i) {
                    final author = widget.data.authorAccounts![i];
                    return body(
                      author.getFullName(),
                    );
                  }),
                  title("Date Approved :"),
                  body(DateFormat("MMMM yyy").format(widget.data.approvedOn!)),
                  title("Abstract :"),
                  Text(
                    widget.data.projectAbstract?.trimRight().trimLeft() ?? "",
                    style: GoogleFonts.poppins(
                      color: CAColors.accent,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          Spacers.formFieldSpacers(),
          if (widget.data.pickedFile != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CAFilePicker(
                    onPicked: (_) {},
                    initialValue:
                        widget.data.pickedFile?.name ?? "No file selected"),
                Spacers.listItemSpacers(),
                Text(
                  "File Size: ${FileSize.formatBytes(widget.data.pickedFile!.size)}",
                  style: hintStyle,
                ),
              ],
            ),
        ],
      ),
    );
  }

  Container title(String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 30),
      child: Text(
        value,
        style: GoogleFonts.poppins(
          color: CAColors.accent,
          fontSize: 12,
        ),
      ),
    );
  }

  Text body(String value) {
    return Text(
      value,
      style: GoogleFonts.poppins(
          color: CAColors.accent, fontSize: 14, fontWeight: FontWeight.w600),
    );
  }
}
