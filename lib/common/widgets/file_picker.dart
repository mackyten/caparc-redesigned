import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../ca_colors.dart';

class CAFilePicker extends StatefulWidget {
  final String? initialValue;
  final Function(PlatformFile? pickedFile) onPicked;
  const CAFilePicker({
    super.key,
    required this.onPicked,
    this.initialValue,
  });

  @override
  State<CAFilePicker> createState() => _CAFilePickerState();
}

class _CAFilePickerState extends State<CAFilePicker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      initialValue: widget.initialValue,
      onTap: () async {
        FilePickerResult? result = await FilePicker.platform
            .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
        if (result != null) {
          widget.onPicked(result.files.first);
        }
      },
    );
  }
}
