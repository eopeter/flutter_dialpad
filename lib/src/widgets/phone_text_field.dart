import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class PhoneTextField extends StatelessWidget {
  /// TextStyle for the text field.
  final TextStyle? textStyle;

  /// The background color of the text field. Defaults to [Colors.white].
  final Color color;

  /// The decoration to show around the text field. Defaults to [InputDecoration(border: InputBorder.none)].
  final InputDecoration decoration;

  /// Callback when the text field is changed.
  final ValueChanged<String>? onChanged;

  /// The controller for the text field.
  final TextEditingController? controller;

  /// Whether the text field is read only. Defaults to false.
  final bool readOnly;

  /// The alignment of the text field. Defaults to [TextAlign.center].
  final TextAlign textAlign;

  const PhoneTextField({
    super.key,
    this.textStyle,
    this.color = Colors.white,
    this.decoration = const InputDecoration(border: InputBorder.none),
    this.onChanged,
    this.readOnly = false,
    this.textAlign = TextAlign.center,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: textStyle,
      decoration: decoration,
      readOnly: readOnly,
      textAlign: textAlign,
      controller: controller,
      onChanged: onChanged,
    );
  }
}
