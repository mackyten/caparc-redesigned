import 'package:caparc/data/models/project_model.dart';
import 'package:caparc/presentation/ca_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Review extends StatefulWidget {
  final ProjectModel item;
  final double bottomNavBarHeight;
  const Review({
    super.key,
    required this.item,
    required this.bottomNavBarHeight,
  });

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  late Size screenSize;
  TextStyle title = const TextStyle(
    color: CAColors.textHigh,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  TextStyle value = TextStyle(
    color: CAColors.textMed,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  @override
  void didChangeDependencies() {
    screenSize = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          constraints: BoxConstraints(
              maxHeight: (screenSize.height - widget.bottomNavBarHeight) - 380,
              minHeight: 100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: CAColors.accent,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "Please carefully review the details of your capstone project.",
                    style: title,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: (screenSize.height - 400),
                  ),
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: CAColors.primary,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: CAColors.shadow,
                        offset: Offset(0, 4),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        RichText(
                          text: TextSpan(
                            style: title,
                            children: [
                              const TextSpan(
                                text: "Title: ",
                              ),
                              TextSpan(
                                text: widget.item.title ?? "<TITLE IS MISSING>",
                                style: value,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RichText(
                          text: TextSpan(
                            style: title,
                            children: [
                              const TextSpan(
                                text: "Authors: ",
                              ),
                              TextSpan(
                                text: widget.item.authorAccounts!
                                    .map((e) => e.getFullName())
                                    .join(", "),
                                style: value,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RichText(
                          text: TextSpan(
                            style: title,
                            children: [
                              const TextSpan(
                                text: "Authors: ",
                              ),
                              TextSpan(
                                text: DateFormat("MMMM yyyy").format(
                                  widget.item.approvedOn ?? DateTime.now(),
                                ),
                                style: value,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Abstract:",
                          style: title,
                        ),
                        Text(
                          widget.item.projectAbstract ?? "",
                          style: value,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
