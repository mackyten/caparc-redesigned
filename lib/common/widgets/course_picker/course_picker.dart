import 'package:caparc/common/models/course_model.dart';
import 'package:caparc/common/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

import '../../../services/firestore_service/query_service.dart';

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
  FirestoreQueryInterface iFirestoreService = FirestoreQuery();
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
    });

    print("Co:${courses.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: courses.isEmpty
          ? CAFormField.textField(
              labelText: "Courses are loading...",
              enabled: false,
            )
          : CAFormField.pickField(
              labelText: 'Select course',
              pickerItems: courses.map((e) => e.description).toList(),
              onItemPicked: (dynamic selected) {
                final picked = courses[selected];
                widget.onItemPicked(picked);
              },
              initialValue: widget.initialValue?.description,
              initialPickedItem: widget.initialValue,
              validator: widget.validator,
            ),
    );
  }
}
