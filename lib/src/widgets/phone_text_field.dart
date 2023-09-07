import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../mixins/scalable.dart';
import 'scalable/scalable.dart';

typedef CopyToClipboardBuilder = Widget Function(BuildContext context, VoidCallback onCopyPressed);

class PhoneTextField extends StatelessWidget with Scalable {
  /// TextStyle for the text field.
  final TextStyle? textStyle;

  /// The background color of the text field. Defaults to [Colors.white].
  final Color color;

  /// The text color of the text field. Defaults to [Colors.grey].
  final Color textColor;

  /// Font size for the text field, as a percentage of the screen height. Defaults to 25.
  final double textSize;

  /// The decoration to show around the text field. Defaults to [InputDecoration(border: InputBorder.none)].
  final InputDecoration decoration;

  /// Callback when the text field is changed.
  final ValueChanged<String>? onChanged;

  /// Add copyToClipboard widget to the text field. Defaults to false.
  final bool copyToClipboard;

  /// The controller for the text field.
  final TextEditingController controller;

  /// Whether the text field is read only. Defaults to false.
  final bool readOnly;

  /// The alignment of the text field. Defaults to [TextAlign.center].
  final TextAlign textAlign;

  /// Builder for the copyToClipboard widget. Defaults to [_defaultCopyToClipboardBuilder].
  final CopyToClipboardBuilder? copyToClipboardBuilder;

  /// [ScalingType] for the button. Defaults to [ScalingType.fixed].
  final ScalingType scalingType;

  /// [ScalingSize] for the button. Defaults to [ScalingSize.small].
  final ScalingSize scalingSize;

  /// Minimum scaling size for the button content. Defaults to null.
  final double? minScalingSize;

  /// Maximum scaling size for the button content. Defaults to null.
  final double? maxScalingSize;

  const PhoneTextField({
    super.key,
    this.textStyle,
    this.color = Colors.white,
    this.textColor = Colors.grey,
    this.textSize = 15,
    this.decoration = const InputDecoration(border: InputBorder.none),
    this.onChanged,
    this.readOnly = false,
    this.textAlign = TextAlign.center,
    this.copyToClipboard = false,
    required this.controller,
    this.copyToClipboardBuilder,
    this.scalingType = ScalingType.fixed,
    this.scalingSize = ScalingSize.small,
    this.minScalingSize,
    this.maxScalingSize,
  });

  void _onCopyPressed() {
    Clipboard.setData(ClipboardData(text: controller.text));
  }

  Widget _defaultCopyToClipboardBuilder() {
    return IconButton(icon: Icon(Icons.copy), onPressed: _onCopyPressed);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final size = rescale(screenSize, scalingType, textSize, scalingSize: scalingSize, minClamp: minScalingSize, maxClamp: maxScalingSize);

    final _builtTextStyle = TextStyle(
      color: textColor,
      fontSize: size,
    );

    final textField = TextFormField(
      style: textStyle ?? _builtTextStyle,
      decoration: decoration,
      readOnly: readOnly,
      textAlign: textAlign,
      controller: controller,
      onChanged: onChanged,
    );

    if (copyToClipboard) {
      return Row(
        children: [
          Expanded(child: textField),
          copyToClipboardBuilder?.call(context, _onCopyPressed) ?? _defaultCopyToClipboardBuilder(),
        ],
      );
    } else {
      return textField;
    }
  }
}
