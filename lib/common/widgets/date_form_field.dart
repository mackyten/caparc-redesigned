import 'package:caparc/common/widgets/text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../ca_colors.dart';

class CADateFormField extends StatefulWidget {
  final DateTime? initialValue;
  final String label;
  final String? Function(String?)? validator;
  final Function(DateTime) onPicked;
  const CADateFormField({
    super.key,
    required this.label,
    this.validator,
    required this.onPicked,
    this.initialValue,
  });

  @override
  State<CADateFormField> createState() => _CADateFormFieldState();
}

class _CADateFormFieldState extends State<CADateFormField> {
  DateTime? _selectedDate;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (widget.initialValue != null) {
      controller.text = DateFormat('yMMMMd').format(widget.initialValue!);
      _selectedDate = widget.initialValue!;
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CADateFormField oldWidget) {
    if (widget.initialValue != oldWidget.initialValue) {
      setState(() {
        if (widget.initialValue != null) {
          controller.text = DateFormat('yMMMMd').format(widget.initialValue!);
          _selectedDate = widget.initialValue!;
        } else {
          controller.clear();
          _selectedDate = null;
        }
      });
      print("OLD DATE");
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectDate,
      child: AbsorbPointer(
        absorbing: true,
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: widget.label,
          ),
          validator: widget.validator,
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    // final DateTime? picked = await showDatePicker(
    //   context: context,
    //   initialDate: _selectedDate,
    //   firstDate: DateTime(1900),
    //   lastDate: DateTime.now(),
    //   builder: (BuildContext context, Widget? child) {
    //     return Theme(
    //       data: ThemeData.light().copyWith(
    //         primaryColor: Colors.blue, // Set primary color
    //         colorScheme:
    //             ColorScheme.light(primary: Colors.blue), // Set color scheme
    //         buttonTheme: ButtonThemeData(
    //           textTheme: ButtonTextTheme.primary, // Set button text color
    //         ),
    //       ),
    //       child: child!,
    //     );
    //   },
    // );
    // if (picked != null && picked != _selectedDate) {
    //   setState(() {
    //     controller.text = DateFormat('yMMMMd').format(picked);
    //   });
    //   widget.onPicked(picked);
    // }

    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      backgroundColor: CAColors.white,
      useSafeArea: true,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 216,
              width: double.infinity,
              decoration: const BoxDecoration(color: Colors.transparent),
              child: CupertinoDatePicker(
                initialDateTime: _selectedDate,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (date) => setState(() {
                  _selectedDate = date;
                }),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                widget.onPicked(_selectedDate ?? DateTime.now());
                if (Navigator.canPop(context)) Navigator.of(context).pop();
              },
              child: const Text("Select"),
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom + 20,
            )
          ],
        );
      },
    );
  }
}
