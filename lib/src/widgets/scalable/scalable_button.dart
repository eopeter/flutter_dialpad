import 'package:flutter/material.dart';

import '../../utils/material_color.dart';
import 'button_type.dart';

/// Material Button with a scalable shape (clipping).
class ScalableButton extends StatelessWidget {
  /// Whether to disable the button. Defaults to false.
  final bool disabled;

  /// Callback when the button is tapped.
  final GestureTapCallback? onPressed;

  /// Callback when the button is long pressed.
  final GestureLongPressCallback? onLongPressed;

  /// Button display style (clipping). Defaults to [ButtonType.rectangle].
  /// [ButtonType.circle] will clip the button to a circle e.g. an iPhone keypad
  /// [ButtonType.rectangle] will clip the button to a rectangle e.g. an Android keypad
  final ButtonType buttonType;

  /// Background color of the button. Defaults to [Colors.grey].
  final Color color;

  /// Padding around the button. Defaults to [EdgeInsets.all(12)].
  final EdgeInsets padding;

  /// The child contained by the button.
  final Widget child;

  const ScalableButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.onLongPressed,
    this.color = Colors.grey,
    this.padding = EdgeInsets.zero,
    this.buttonType = ButtonType.rectangle,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    // Use MaterialButton to get the Material ripple, splash and highlight colors including animations and gestures.
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: buttonType == ButtonType.rectangle ? BoxShape.rectangle : BoxShape.circle,
      ),
      child: MaterialButton(
        color: createMaterialColor(color),
        onPressed: disabled ? null : onPressed,
        onLongPress: disabled ? null : onLongPressed,
        animationDuration: Duration(milliseconds: 300),
        child: Center(
          child: child,
        ),
        padding: padding,
        elevation: 0,
        highlightElevation: 0,
        hoverElevation: 0,
      ),
    );
  }
}
