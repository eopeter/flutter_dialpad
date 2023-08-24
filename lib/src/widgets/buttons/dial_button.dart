import 'dart:math';
import 'package:flutter/material.dart';

import '../../utils/material_color.dart';
import 'button_type.dart';

class DialButton extends StatefulWidget {
  final Key? key;

  /// Title to display on the button. If [icon] is provided, this will be ignored.
  final String? title;

  /// Subtitle (hint) to display below the title. If [subtitleIcon] is provided, this will be ignored. If neither are provided, subtitle (hint) will be hidden.
  final String? subtitle;

  /// Whether to hide the subtitle (hint). Defaults to false.
  final bool hideSubtitle;

  /// Background color of the button. Defaults to system/material color.
  final Color color;

  /// Text color of the button. Defaults to [Colors.black].
  final Color textColor;

  /// Icon to replace the title.
  final IconData? icon;

  /// Icon to replace the subtitle (hint). If not provided, subtitle (hint) will be used or hidden if not provided.
  final IconData? subtitleIcon;

  /// Color of the title icon. Defaults to [Colors.white].
  final Color iconColor;

  /// Color of the subtitle icon. Defaults to [iconColor].
  final Color? subtitleIconColor;

  /// Callback when the button is tapped.
  final ValueSetter<String?>? onTap;

  /// Button display style (clipping). Defaults to [ButtonType.rectangle].
  /// [ButtonType.circle] will clip the button to a circle e.g. an iPhone keypad
  /// [ButtonType.rectangle] will clip the button to a rectangle e.g. an Android keypad
  final ButtonType buttonType;

  /// Padding around the button. Defaults to [EdgeInsets.all(12)].
  final EdgeInsets padding;

  /// Font size for the title, as a percentage of the screen height. Defaults to 75.
  ///
  /// For example, if the screen height/width (the smaller of the 2) is 1000, the title font size will be 75.
  final double fontSize;

  /// Font size for the subtitle, as a percentage of the screen height. Defaults to 25.
  ///
  /// For example, if the screen height/width (the smaller of the 2) is 1000, the title font size will be 25.
  final double subtitleFontSize;

  /// Icon size (icon which replaces title), as a percentage of the screen height. Defaults to 75.
  ///
  /// For example, if the screen height/width (the smaller of the 2) is 1000, the icon size will be 75.
  final double iconSize;

  /// Icon size (icon which replaces subtitle), as a percentage of the screen height. Defaults to 35.
  ///
  /// For example, if the screen height/width (the smaller of the 2) is 1000, the icon size will be 35.
  final double subtitleIconSize;

  DialButton({
    this.key,
    this.title,
    this.subtitle,
    this.hideSubtitle = false,
    this.color = Colors.grey,
    this.textColor = Colors.black,
    this.icon,
    this.subtitleIcon,
    this.iconColor = Colors.white,
    this.subtitleIconColor,
    this.onTap,
    this.buttonType = ButtonType.rectangle,
    this.padding = const EdgeInsets.all(0),
    this.fontSize = 75,
    this.subtitleFontSize = 25,
    this.iconSize = 75,
    this.subtitleIconSize = 35,
  });

  @override
  _DialButtonState createState() => _DialButtonState();
}

class _DialButtonState extends State<DialButton> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double unitTextSize = min(size.height, size.width) * 0.001;

    // Get title widget, prefer icon over title
    Widget titleWidget = widget.icon != null
        ? Icon(widget.icon, size: widget.iconSize * unitTextSize, color: widget.iconColor)
        : Text(
            widget.title!,
            style: TextStyle(
              fontSize: unitTextSize * (widget.fontSize),
              color: widget.textColor,
            ),
          );

    // Get subtitle widget, prefer subtitleIcon over subtitle
    final subtitleWidget = widget.subtitleIcon != null
        ? Icon(widget.subtitleIcon, size: widget.subtitleIconSize * unitTextSize, color: widget.subtitleIconColor ?? widget.iconColor)
        : (widget.subtitle != null)
            ? Text(
                widget.subtitle ?? "",
                style: TextStyle(color: widget.textColor, fontSize: unitTextSize * widget.subtitleFontSize),
              )
            : null;

    // correction for asterisk being "higher" than other buttons (only if we don't have subtitles to show)
    titleWidget = widget.title == "*" && (subtitleWidget == null || widget.hideSubtitle == true)
        ? Transform.translate(
            offset: Offset(0, 10 * unitTextSize),
            child: titleWidget,
          )
        : titleWidget;

    // Create dial button text content
    final child = Center(
      child: subtitleWidget == null || widget.hideSubtitle == true
          ? titleWidget
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                titleWidget,
                subtitleWidget,
              ],
            ),
    );

    final materialColor = createMaterialColor(widget.color);
    final splashColor = materialColor[200];
    final highlightColor = materialColor[800];

    // Use MaterialButton to get the Material ripple, splash and highlight colors including animations and gestures.
    return Padding(
      padding: widget.padding,
      // child: MaterialButton(
      child: MaterialButton(
        splashColor: splashColor,
        highlightColor: highlightColor,
        color: materialColor,
        onPressed: widget.onTap != null ? () => widget.onTap!.call(widget.title) : null,
        onLongPress: !widget.hideSubtitle && widget.onTap != null ? () => widget.onTap!.call(widget.subtitle) : null,
        animationDuration: Duration(milliseconds: 300),
        child: child,
        shape: widget.buttonType == ButtonType.rectangle ? RoundedRectangleBorder(borderRadius: BorderRadius.zero) : CircleBorder(),
        materialTapTargetSize: widget.buttonType == ButtonType.rectangle ? MaterialTapTargetSize.padded : MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
        elevation: 0,
        highlightElevation: 0,
        hoverElevation: 0,
      ),
    );
  }
}
