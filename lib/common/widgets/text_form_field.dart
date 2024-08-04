import 'package:flutter/material.dart';

class CATextFormField extends StatefulWidget {
  final String labelText;
  final String? Function(String?)? validator;
  final String? initialValue;
  final TextEditingController? controller;
  final Function(String?)? onChange;

  const CATextFormField(
      {super.key,
      required this.labelText,
      this.validator,
      this.initialValue,
      this.controller,
      this.onChange});

  @override
  State<CATextFormField> createState() => _CATextFormFieldState();
}

class _CATextFormFieldState extends State<CATextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      onChanged: widget.onChange,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),
      validator: widget.validator,
    );
  }
}
