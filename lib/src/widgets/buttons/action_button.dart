import 'package:flutter/material.dart';
import '../../mixins/scalable.dart';
import '../scalable/scalable.dart';

class ActionButton extends StatelessWidget with Scalable {
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
  final VoidCallback? onTap;

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

  /// Whether to disable the button. Defaults to false.
  final bool disabled;

  /// [ScalingType] for the button. Defaults to [ScalingType.fixed].
  final ScalingType scalingType;

  /// [ScalingSize] for the button. Defaults to [ScalingSize.small].
  final ScalingSize scalingSize;

  final EdgeInsets? contentPadding;

  ActionButton({
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
    this.disabled = false,
    this.scalingType = ScalingType.fixed,
    this.scalingSize = ScalingSize.small,
    this.contentPadding,
  });

  /// Get title widget, prefer icon over title
  Widget _buildTitleWidget(Size screenSize) {
    double size = rescale(screenSize, scalingType, icon != null ? iconSize : fontSize, scalingSize: scalingSize);
    Widget widget = icon != null
        ? Icon(icon, size: size, color: iconColor)
        : Text(
            title!,
            style: TextStyle(
              fontSize: size,
              color: textColor,
            ),
          );

    // correction for asterisk being "higher" than other buttons (only if we don't have subtitles to show)
    bool hasSubtitle = (subtitleIcon == null && subtitle == null);
    bool showSubtitle = hasSubtitle && !hideSubtitle;
    if (title == "*" && !showSubtitle) {
      widget = Transform.translate(
        offset: Offset(0, 10 * size),
        child: widget,
      );
    }
    return widget;
  }

  /// Get subtitle widget, prefer subtitleIcon over subtitle
  Widget? _buildSubtitleWidget(Size screenSize) {
    return subtitleIcon != null
        ? Icon(subtitleIcon, size: rescale(screenSize, scalingType, subtitleIconSize, scalingSize: scalingSize), color: subtitleIconColor ?? iconColor)
        : (subtitle != null)
            ? Text(
                subtitle ?? "",
                style: TextStyle(color: textColor, fontSize: rescale(screenSize, scalingType, subtitleFontSize, scalingSize: scalingSize)),
              )
            : null;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      Size size = constraints.biggest;

      // Get title widget, prefer icon over title
      Widget titleWidget = _buildTitleWidget(size);

      // Get subtitle widget, prefer subtitleIcon over subtitle
      final subtitleWidget = _buildSubtitleWidget(size);

      // Create dial button text content
      final child = subtitleWidget == null || hideSubtitle == true
          ? titleWidget
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                titleWidget,
                subtitleWidget,
              ],
            );

      return Padding(
        padding: padding,
        child: ScalableButton(
          color: color,
          buttonType: buttonType,
          disabled: disabled,
          child: child,
          onTap: onTap != null ? onTap : null,
          padding: contentPadding ?? EdgeInsets.all(0),
        ),
      );
    });
  }
}
