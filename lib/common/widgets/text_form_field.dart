import 'package:flutter/material.dart';

class CATextFormField extends StatefulWidget {
  final String labelText;
  final String? Function(String?)? validator;
  final String? initialValue;
  final TextEditingController? controller;
  final Widget? prefix;
  final Function(String?)? onChange;
  final bool? enabled;

  const CATextFormField(
      {super.key,
      required this.labelText,
      this.validator,
      this.initialValue,
      this.controller,
      this.onChange,
      this.prefix,
      this.enabled});

  @override
  State<CATextFormField> createState() => _CATextFormFieldState();
}

class _CATextFormFieldState extends State<CATextFormField> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    if (widget.controller != null) {
      controller = widget.controller!;
    }

    controller.text = widget.initialValue ?? "";

    print("INITIAL: ${widget.initialValue}");
    super.initState();
  }

  // @override
  // void didUpdateWidget(covariant CATextFormField oldWidget) {
  //   if (oldWidget.initialValue != widget.initialValue) {
  //     setState(() {
  //       controller.text = widget.initialValue ?? "";
  //     });
  //     print("REBUILD");
  //   }
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.enabled,
      initialValue: widget.initialValue,
      onChanged: widget.onChange,
      decoration: InputDecoration(
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
