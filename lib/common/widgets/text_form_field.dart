import 'package:caparc/common/values.dart';
import 'package:caparc/common/widgets/buttons/profile_button.dart';
import 'package:caparc/common/widgets/spacers.dart';
import 'package:caparc/presentation/ca_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ming_cute_icons/ming_cute_icons.dart';

class CAFormField {
  static Widget textField({
    String? labelText,
    String? Function(String? value)? validator,
    String? initialValue,
    TextEditingController? controller,
    Widget? prefix,
    Function(String? val)? onChange,
    bool? enabled,
    int? minLine,
    Function(String val)? onFieldSubmitted,
    String? helperText,
    String? hintText,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    TextCapitalization? textCapitalization,
    FocusNode? focusNode,
    bool? autoFocus,
  }) {
    return CATextFormField(
      labelText: labelText,
      validator: validator,
      initialValue: initialValue,
      controller: controller,
      prefix: prefix,
      onChange: onChange,
      enabled: enabled,
      minLine: minLine,
      onFieldSubmitted: onFieldSubmitted,
      helperText: helperText,
      hintText: hintText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      focusNode: focusNode,
      autoFocus: autoFocus,
    );
  }

  static Widget dateField({
    String? labelText,
    String? Function(String?)? validator,
    DateTime? initialValue,
    TextEditingController? controller,
    Widget? prefix,
    Function(String? val)? onChange,
    bool? enabled,
    int? minLine,
    Function(String val)? onFieldSubmitted,
    String? helperText,
    String? hintText,
    required Function(DateTime) onDateChanged,
  }) {
    return CATextFormField(
      labelText: labelText,
      validator: validator,
      initialValue: initialValue == null
          ? null
          : DateFormat("MMMM dd, yyyy").format(
              initialValue,
            ),
      controller: controller,
      prefix: prefix,
      onChange: onChange,
      enabled: enabled,
      minLine: 1,
      onFieldSubmitted: onFieldSubmitted,
      helperText: helperText,
      hintText: hintText,
      datePicker: true,
      onDateChanged: onDateChanged,
    );
  }

  static Widget pickField(
      {String? labelText,
      String? Function(String?)? validator,
      String? initialValue,
      TextEditingController? controller,
      Widget? prefix,
      Function(String? val)? onChange,
      bool? enabled,
      int? minLine,
      Function(String val)? onFieldSubmitted,
      String? helperText,
      String? hintText,
      final Function(dynamic val)? onItemPicked,
      final bool? isPicker,
      final List<dynamic>? pickerItems,
      dynamic initialPickedItem}) {
    return CATextFormField(
      initialValue: initialValue,
      labelText: labelText,
      validator: validator,
      controller: controller,
      prefix: prefix,
      onChange: onChange,
      enabled: enabled,
      minLine: 1,
      onFieldSubmitted: onFieldSubmitted,
      helperText: helperText,
      hintText: hintText,
      onItemPicked: onItemPicked,
      pickerItems: pickerItems,
      isPicker: true,
      initialPickedItem: initialPickedItem,
    );
  }
}

class CATextFormField extends StatefulWidget {
  final String? labelText;
  final String? Function(String? validator)? validator;
  final String? initialValue;
  final TextEditingController? controller;
  final Widget? prefix;
  final Function(String? val)? onChange;
  final bool? enabled;
  final int? minLine;
  final int? maxLines;
  final Function(String val)? onFieldSubmitted;
  final String? helperText;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final bool? datePicker;
  final Function(DateTime date)? onDateChanged;

  final Function(dynamic val)? onItemPicked;
  final bool? isPicker;
  final List<dynamic>? pickerItems;
  final dynamic initialPickedItem;
  final FocusNode? focusNode;
  final bool? autoFocus;
  final bool? enableSuggestions;
  final bool? autocorrect;
  final bool? obscureText;

  const CATextFormField(
      {super.key,
      this.labelText,
      this.validator,
      this.initialValue,
      this.controller,
      this.onChange,
      this.prefix,
      this.enabled,
      this.minLine,
      this.maxLines,
      this.onFieldSubmitted,
      this.helperText,
      this.hintText,
      this.keyboardType,
      this.textInputAction,
      this.textCapitalization = TextCapitalization.none,
      this.datePicker = false,
      this.onDateChanged,
      this.onItemPicked,
      this.isPicker,
      this.pickerItems,
      this.initialPickedItem,
      this.focusNode,
      this.autoFocus,
      this.enableSuggestions,
      this.autocorrect,
      this.obscureText});

  @override
  State<CATextFormField> createState() => _CATextFormFieldState();
}

class _CATextFormFieldState extends State<CATextFormField> {
  late TextEditingController _controller;
  bool isPicking = false;
  int pickedItem = 0;
  bool? isEnabled() {
    return widget.isPicker == true
        ? (widget.pickerItems != null && widget.pickerItems!.isNotEmpty)
        : widget.enabled;
  }

  @override
  void initState() {
    if (widget.datePicker == true) {
      assert(widget.onDateChanged != null, "onPickedDate is required.");
    } else if (widget.isPicker == true) {
      assert(widget.onItemPicked != null, "onItemPicked is required.");
      assert(widget.pickerItems != null || widget.pickerItems!.isNotEmpty,
          "Please add pick items");

      if (widget.initialPickedItem != null) {
        pickedItem = widget.pickerItems!.indexOf(widget.initialPickedItem);
      }
    }

    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.text = widget.initialValue ?? "";
  }

  @override
  void didUpdateWidget(CATextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialValue != oldWidget.initialValue && mounted) {
        _controller.text = widget.initialValue ?? "";
      }
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autoFocus ?? false,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      controller: _controller,
      enabled: isEnabled(),
      onChanged: widget.onChange,
      minLines: widget.minLine,
      maxLines: widget.maxLines,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.words,
      enableSuggestions: widget.enableSuggestions ?? true,
      autocorrect: widget.autocorrect ?? true,
      cursorColor: CAColors.accent,
      obscureText: widget.obscureText ?? false,
      style: GoogleFonts.poppins(
          color: isEnabled() == false
              ? CAColors.text
              : CAColors.accent.withOpacity(.80)),
      decoration: InputDecoration(
        helperText: widget.helperText,
        hintText: widget.hintText,
        prefixIcon: widget.prefix,
        labelText: widget.labelText,
        labelStyle: GoogleFonts.poppins(
          color: isEnabled() == false ? CAColors.text : CAColors.accent,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        suffixIcon: widget.isPicker == true
            ? Icon(
                isPicking
                    ? MingCuteIcons.mgc_up_fill
                    : MingCuteIcons.mgc_down_fill,
              )
            : null,
        suffixIconColor: isEnabled() == true ? CAColors.accent : CAColors.text,
        hintStyle: GoogleFonts.poppins(
            color: isEnabled() == true ? CAColors.accent : CAColors.text),
        enabledBorder: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: CAColors.accent),
        ),
        border: const OutlineInputBorder(),
      ),
      validator: widget.validator,
      readOnly: (widget.datePicker == true || widget.isPicker == true),
      onTap: onTap,
    );
  }

  Future<void> onTap() async {
    if (widget.datePicker == true) {
      showModalBottomSheet(
        showDragHandle: true,
        context: context,
        backgroundColor: CAColors.white,
        useSafeArea: true,
        builder: (_) {
          return Container(
            height: 216,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.transparent),
            child: CupertinoDatePicker(
              initialDateTime: widget.initialValue != null
                  ? DateFormat("MMMM dd, yyyy").parse(widget.initialValue!)
                  : null,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: widget.onDateChanged!,
            ),
          );
        },
      );
    } else if (widget.isPicker == true) {
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

          if (widget.pickerItems?.first is String) {
            items = widget.pickerItems!.map((e) => e.toString()).toList();
          } else {
            items = widget.pickerItems!
                .map((e) =>
                    "Unsupported type of ${widget.pickerItems.runtimeType}")
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
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: CupertinoPicker(
                    scrollController:
                        FixedExtentScrollController(initialItem: pickedItem),
                    itemExtent: 40,
                    onSelectedItemChanged: (c) {
                      pickedItem = c;
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
                  widget.onItemPicked!(pickedItem);
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
    }
  }
}
