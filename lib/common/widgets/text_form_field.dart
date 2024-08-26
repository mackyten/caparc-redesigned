import 'package:flutter/material.dart';

class CATextFormField extends StatefulWidget {
  final String? labelText;
  final String? Function(String?)? validator;
  final String? initialValue;
  final TextEditingController? controller;
  final Widget? prefix;
  final Function(String?)? onChange;
  final bool? enabled;
  final int? minLine;
  final Function(String val)? onFieldSubmitted;
  final String? helperText;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const CATextFormField({
    super.key,
    this.labelText,
    this.validator,
    this.initialValue,
    this.controller,
    this.onChange,
    this.prefix,
    this.enabled,
    this.minLine = 1,
    this.onFieldSubmitted,
    this.helperText,
    this.hintText,
    this.keyboardType,
    this.textInputAction,
  });

  @override
  State<CATextFormField> createState() => _CATextFormFieldState();
}

class _CATextFormFieldState extends State<CATextFormField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    // Set the initial text
    _controller.text = widget.initialValue ?? "";
  }

  @override
  void didUpdateWidget(CATextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update controller text if initialValue changes
    if (widget.initialValue != oldWidget.initialValue && mounted) {
      _controller.text = widget.initialValue ?? "";
    }
  }

  @override
  void dispose() {
    // Dispose controller if it was created locally
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      controller: _controller,
      enabled: widget.enabled,
      onChanged: widget.onChange,
      minLines: widget.minLine,
      maxLines: widget.minLine,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        helperText: widget.helperText,
        hintText: widget.hintText,
        prefixIcon: widget.prefix,
        labelText: widget.labelText,
        enabledBorder: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(),
        border: OutlineInputBorder(),
      ),
      validator: widget.validator,
    );
  }
}
