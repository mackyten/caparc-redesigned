import 'package:caparc/common/widgets/text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CADateFormField extends StatefulWidget {
  final String label;
  final String? Function(String?)? validator;
  final Function(DateTime) onPicked;
  const CADateFormField(
      {super.key, required this.label, this.validator, required this.onPicked});

  @override
  State<CADateFormField> createState() => _CADateFormFieldState();
}

class _CADateFormFieldState extends State<CADateFormField> {
  DateTime? _selectedDate;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectDate,
      child: AbsorbPointer(
        absorbing: true,
        child: CATextFormField(
          controller: controller,
          labelText: widget.label,
          validator: widget.validator,
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue, // Set primary color
            colorScheme:
                ColorScheme.light(primary: Colors.blue), // Set color scheme
            buttonTheme: ButtonThemeData(
              textTheme: ButtonTextTheme.primary, // Set button text color
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        controller.text = DateFormat('yMMMMd').format(picked);
      });
      widget.onPicked(picked);
    }
  }
}
