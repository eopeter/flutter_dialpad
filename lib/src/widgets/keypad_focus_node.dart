import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/key_value.dart';

/// This widget is used to capture key events from the keyboard, and translate them into [DigitKey] or [ActionKey] events.
class KeypadFocusNode extends StatelessWidget {
  /// This callback is called when a key is pressed on the keyboard.
  final ValueChanged<KeyValue> onKeypadPressed;

  /// The child widget that will be focused.
  final Widget child;

  const KeypadFocusNode({super.key, required this.onKeypadPressed, required this.child});

  /// Handles the key events from the keyboard, and translates them into [DigitKey] or [ActionKey] events that are passed to [onKeypadPressed].
  /// Returns [KeyEventResult.handled] if the event was handled, or [KeyEventResult.ignored] if the event was ignored.
  KeyEventResult _handleOnKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      final physicalKey = event.physicalKey;
      final logicalKey = event.logicalKey;
      if (physicalKey == PhysicalKeyboardKey.numpad0 || physicalKey == PhysicalKeyboardKey.digit0) {
        onKeypadPressed(DigitKey(0));
      } else if (physicalKey == PhysicalKeyboardKey.numpad1 || physicalKey == PhysicalKeyboardKey.digit1) {
        onKeypadPressed(DigitKey(1));
      } else if (physicalKey == PhysicalKeyboardKey.numpad2 || physicalKey == PhysicalKeyboardKey.digit2) {
        onKeypadPressed(DigitKey(2));
      } else if (physicalKey == PhysicalKeyboardKey.numpad3 || physicalKey == PhysicalKeyboardKey.digit3) {
        onKeypadPressed(DigitKey(3));
      } else if (physicalKey == PhysicalKeyboardKey.numpad4 || physicalKey == PhysicalKeyboardKey.digit4) {
        onKeypadPressed(DigitKey(4));
      } else if (physicalKey == PhysicalKeyboardKey.numpad5 || physicalKey == PhysicalKeyboardKey.digit5) {
        onKeypadPressed(DigitKey(5));
      } else if (physicalKey == PhysicalKeyboardKey.numpad6 || physicalKey == PhysicalKeyboardKey.digit6) {
        onKeypadPressed(DigitKey(6));
      } else if (physicalKey == PhysicalKeyboardKey.numpad7 || physicalKey == PhysicalKeyboardKey.digit7) {
        onKeypadPressed(DigitKey(7));
      } else if (physicalKey == PhysicalKeyboardKey.numpad8 || physicalKey == PhysicalKeyboardKey.digit8) {
        onKeypadPressed(DigitKey(8));
      } else if (physicalKey == PhysicalKeyboardKey.numpad9 || physicalKey == PhysicalKeyboardKey.digit9) {
        onKeypadPressed(DigitKey(9));
      } else if (physicalKey == PhysicalKeyboardKey.numpadMultiply || logicalKey == LogicalKeyboardKey.asterisk) {
        onKeypadPressed(ActionKey.asterisk());
      } else if (physicalKey == PhysicalKeyboardKey.numpadAdd || logicalKey == LogicalKeyboardKey.add) {
        onKeypadPressed(ActionKey.plus());
      } else if (logicalKey == LogicalKeyboardKey.numberSign) {
        onKeypadPressed(ActionKey.hash());
      } else if (logicalKey == LogicalKeyboardKey.backspace) {
        onKeypadPressed(ActionKey.backspace());
      } else {
        return KeyEventResult.ignored;
      }
      return KeyEventResult.handled;
    } else {
      return KeyEventResult.ignored;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onKeyEvent: _handleOnKeyEvent,
      autofocus: true,
      child: child,
    );
  }
}