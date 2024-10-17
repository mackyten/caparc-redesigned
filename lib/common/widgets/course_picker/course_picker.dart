import 'package:caparc/common/ca_colors.dart';
import 'package:caparc/common/models/course_model.dart';
import 'package:caparc/common/widgets/text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

import '../../../services/firestore_service/query_service.dart';
import '../../values.dart';
import '../buttons/profile_button.dart';
import '../spacers.dart';

class CoursePicker extends StatefulWidget {
  final Function(CourseModel course) onItemPicked;
  final String? Function(String?)? validator;
  final CourseModel? initialValue;
  const CoursePicker(
      {super.key,
      required this.onItemPicked,
      this.initialValue,
      this.validator});

  @override
  State<CoursePicker> createState() => _CoursePickerState();
}

class _CoursePickerState extends State<CoursePicker> {
  List<CourseModel> courses = [];
  bool isPicking = false;
  FirestoreQueryInterface iFirestoreService = FirestoreQuery();
  int pickedItem = 0;
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _initialize();
    super.initState();
  }

  Future<void> _initialize() async {
    print("INITIALIZE COURSE");
    final result = await iFirestoreService.getCourses();
    setState(() {
      courses = result;
      _textEditingController.text = widget.initialValue?.description ?? '';
    });

    print("Co:${courses.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: TextFormField(
        readOnly: true,
        controller: _textEditingController,
        decoration: InputDecoration(
          labelText:
              courses.isEmpty ? 'Courses are loading...' : 'Select course',
          suffix: Icon(
            isPicking ? MingCuteIcons.mgc_up_fill : MingCuteIcons.mgc_down_fill,
          ),
        ),
        enabled: courses.isNotEmpty,
        onTap: () async {
          if (mounted) {
            setState(() {
              isPicking = true;
            });
          }
          await showModalBottomSheet(
            showDragHandle: true,
            context: context,
            backgroundColor: CAColors.white,
            useSafeArea: true,
            builder: (_) {
              List<String> items = [];

              if (courses.map((e) => e.description).toList()?.first is String) {
                items = courses
                    .map((e) => e.description)
                    .toList()!
                    .map((e) => e.toString())
                    .toList();
              } else {
                items = courses
                    .map((e) => e.description)
                    .toList()!
                    .map((e) =>
                        "Unsupported type of ${courses.map((e) => e.description).toList().runtimeType}")
                    .toList();
              }

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: insidePadding,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 120,
                      width: double.infinity,
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                            initialItem: pickedItem),
                        itemExtent: 40,
                        onSelectedItemChanged: (c) {
                          setState(() {
                            pickedItem = c;
                          });
                        },
                        children: List.generate(items.length, (index) {
                          final item = items[index];
                          return Center(
                            child: SizedBox(
                              width: 300,
                              child: Tooltip(
                                message: item,
                                child: Text(
                                  item,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Spacers.formFieldSpacers(),
                    CAButtons.proceed(() {
                      final picked = courses[pickedItem];
                      widget.onItemPicked(picked);
                      setState(() {
                        _textEditingController.text = picked.description ?? '';
                      });
                      Navigator.of(context).pop();
                    }),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    )
                  ],
                ),
              );
            },
          );
          if (mounted) {
            setState(() {
              isPicking = false;
            });
          }
        },
        // initialValue: widget.initialValue?.description,
        validator: widget.validator,
      ),
    );
  }
}
