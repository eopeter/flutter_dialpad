library flutter_dialpad;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
// disabled temporarily
// import 'package:flutter_dtmf/dtmf.dart';

import 'src/flutter_dialpad.dart';

export 'src/flutter_dialpad.dart';

typedef DialPadButtonBuilder = Widget Function(BuildContext context, int index, KeyValue key, KeyValue? altKey, String? hint);

class DialPad extends StatefulWidget {
  /// Callback when the dial button is pressed.
  final ValueSetter<String>? makeCall;

  /// Callback when a key is pressed.
  final ValueSetter<String>? keyPressed;

  /// Whether to hide the dial button. Defaults to false.
  final bool hideDialButton;

  /// Whether to hide the backspace button. Defaults to false.
  final bool hideBackspaceButton;

  /// Whether to hide the subtitle on the dial pad buttons. Defaults to [false].
  final bool hideSubtitle;

  /// buttonColor is the color of the button on the dial pad. defaults to [Colors.grey]
  final Color buttonColor;

  /// Color of the button text, defaults to [Colors.black]
  final Color buttonTextColor;

  /// Color of the dial button, defaults to [Colors.green]
  final Color dialButtonColor;

  /// Color of the dial button icon, defaults to [Colors.white]
  final Color dialButtonIconColor;

  /// Icon for the dial button, defaults to [Icons.phone]
  final IconData dialButtonIcon;

  /// Color of the backspace button icon, defaults to [Colors.grey]
  final Color backspaceButtonIconColor;

  /// Color of the output text, defaults to [Colors.black]
  final Color dialOutputTextColor;

  /// Font size for the output text, defaults to 75
  /// Text scales with the screen size using the shortest between (height & width) * 0.001 multiplied by the [dialOutputTextSize] value
  final double dialOutputTextSize;

  /// Font size for the output text, defaults to 75
  final double buttonTextSize;

  /// Font size for the output text, defaults to 25
  /// Text scales with the screen size using the shortest between (height & width) * 0.001 multiplied by the [subtitleTextSize] value
  final double subtitleTextSize;

  /// outputMask is the mask applied to the output text. Defaults to (000) 000-0000
  final String outputMask;
  final String hint;

  /// Whether to enable DTMF tones. Defaults to [false].
  /// Disabled temporarily until [flutter_dtmf] has been updated.
  final bool enableDtmf;

  /// Builder for the keypad buttons. Defaults to [DialPadButtonBuilder].
  /// Note: this has not yet been fully integrated for customer use - this will be available in a future release.
  final DialPadButtonBuilder? keypadButtonBuilder;

  /// Generator for the keypad buttons. Defaults to [PhoneKeypadGenerator].
  final KeypadIndexedGenerator? generator;

  /// Button display style (clipping). Defaults to [ButtonType.rectangle].
  final ButtonType buttonType;

  /// Padding around the button. Defaults to [EdgeInsets.all(0)].
  final EdgeInsets buttonPadding;

  /// Whether to call [makeCall] when the enter key is pressed. Defaults to false.
  final bool callOnEnter;

  /// Whether to copy the text to the clipboard when the text field is tapped. Defaults to true.
  final bool copyToClipboard;

  /// Whether to paste the text from the clipboard when the text field is tapped. Defaults to true.
  final bool pasteFromClipboard;

  /// Padding around the text field. Defaults to [EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 16)].
  final EdgeInsets textFieldPadding;

  DialPad({
    this.makeCall,
    this.keyPressed,
    this.hideDialButton = false,
    this.hideBackspaceButton = false,
    this.hideSubtitle = false,
    this.outputMask = '(000) 000-0000',
    this.hint = '(000) 000-0000',
    this.buttonColor = Colors.grey,
    this.buttonTextColor = Colors.black,
    this.dialButtonColor = Colors.green,
    this.dialButtonIconColor = Colors.white,
    this.dialButtonIcon = Icons.phone,
    this.dialOutputTextColor = Colors.black,
    this.dialOutputTextSize = 75,
    this.buttonTextSize = 75,
    this.subtitleTextSize = 25,
    this.backspaceButtonIconColor = Colors.grey,
    this.enableDtmf = false,
    @Deprecated('This has not yet been fully integrated for customer use and thus has no effect on the output - will be available in a future release.')
    this.keypadButtonBuilder,
    this.generator = const PhoneKeypadGenerator(),
    this.buttonType = ButtonType.rectangle,
    this.buttonPadding = const EdgeInsets.all(0),
    this.callOnEnter = false,
    this.copyToClipboard = true,
    this.pasteFromClipboard = true,
    this.textFieldPadding = const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 16),
  });

  /// Returns a [DialPad] with an iOS-style design (i.e. Apple).
  factory DialPad.ios({
    ValueSetter<String>? makeCall,
    ValueSetter<String>? keyPressed,
  }) {
    return DialPad(
      makeCall: makeCall,
      keyPressed: keyPressed,
      // Cupertino icons should be used here
      dialButtonIcon: Icons.phone,
      backspaceButtonIconColor: Colors.grey,
      generator: IosKeypadGenerator(),
      dialOutputTextColor: Colors.black87,
      buttonTextColor: Colors.black87,
      buttonColor: Colors.grey[300]!,
      buttonType: ButtonType.circle,
      buttonPadding: EdgeInsets.all(16),
      dialOutputTextSize: 75,
    );
  }

  /// Creates a dial pad with a metro-style (i.e. Windows).
  factory DialPad.metro({
    ValueSetter<String>? makeCall,
    ValueSetter<String>? keyPressed,
  }) {
    return DialPad(
      makeCall: makeCall,
      keyPressed: keyPressed,
      // Cupertino icons should be used here
      dialButtonIcon: Icons.phone,
      backspaceButtonIconColor: Colors.grey,
      generator: PhoneKeypadGenerator(),
      dialOutputTextColor: Colors.black87,
      buttonTextColor: Colors.black54,
      buttonColor: Colors.white,
      buttonType: ButtonType.rectangle,
      dialOutputTextSize: 75,
      dialButtonColor: Colors.blue,
    );
  }

  @override
  State<DialPad> createState() => _DialPadState();
}

class _DialPadState extends State<DialPad> {
  late final MaskedTextController _controller;
  String _value = "";

  @override
  void initState() {
    super.initState();
    _controller = MaskedTextController(mask: widget.outputMask);
  }

  /// Handles keypad button press, this includes numbers and [DialActionKey] except [DialActionKey.backspace]
  void _onKeyPressed(String? value) {
    if (value != null) {
      setState(() {
        _value += value;
        _controller.updateText(_value);
      });
    }
  }

  /// Handles backspace button press
  void _onBackspacePressed() {
    if (_value.isEmpty) {
      return;
    }

    setState(() {
      _value = _value.substring(0, _value.length - 1);
      _controller.text = _value;
    });
  }

  /// Handles dial button press
  void _onDialPressed() {
    if (widget.makeCall != null && _value.isNotEmpty) {
      widget.makeCall!(_value);
    }
  }

  /// Handles keyboard button presses
  void _onKeypadPressed(KeyValue key) {
    if (key is ActionKey && key.action == DialActionKey.backspace) {
      // handle backspace
      _onBackspacePressed();
    } else if (key is ActionKey && key.action == DialActionKey.enter) {
      if (widget.callOnEnter) {
        _onDialPressed();
      }
    } else {
      // For numbers, and all actions except backspace
      _onKeyPressed(key.value);
    }
  }

  Widget _defaultDialButtonBuilder(BuildContext context, int index, KeyValue key, KeyValue? altKey, String? hint) {
    return ActionButton(
      title: key.value,
      subtitle: altKey?.value ?? hint,
      color: widget.buttonColor,
      hideSubtitle: widget.hideSubtitle,
      onTap: () => _onKeypadPressed(key),
      buttonType: widget.buttonType,
      padding: widget.buttonPadding,
      textColor: widget.buttonTextColor,
      iconColor: widget.buttonTextColor,
      subtitleIconColor: widget.buttonTextColor,
      subtitleFontSize: widget.subtitleTextSize,
      fontSize: widget.buttonTextSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final sizeFactor = min(screenSize.height, screenSize.width) * 0.001;

    final _keypadButtonBuilder = /*widget.keypadButtonBuilder ??  */_defaultDialButtonBuilder;
    final _generator = widget.generator ?? IosKeypadGenerator();

    /// Dial button
    final dialButton = widget.hideDialButton
        ? null
        : ActionButton(
            padding: widget.buttonPadding,
            buttonType: widget.buttonType,
            icon: widget.dialButtonIcon,
            iconColor: widget.dialButtonIconColor,
            color: widget.dialButtonColor,
            onTap: _onDialPressed,
            // NOTE(cybex-dev) add as option in future
            // disabled: _value.isEmpty || widget.makeCall == null,
          );

    /// Backspace button
    final backspaceButton = widget.hideBackspaceButton
        ? null
        : ActionButton(
            onTap: _onBackspacePressed,
            disabled: _value.isEmpty,
            buttonType: widget.buttonType,
            iconSize: 75,
            iconColor: widget.backspaceButtonIconColor,
            padding: widget.buttonPadding,
            icon: Icons.backspace,
            color: Colors.transparent,
          );

    /// Footer contains the dial and backspace buttons
    final footer = dialButton == null && backspaceButton == null
        ? null
        : Row(
            children: [
              Expanded(child: Container()),
              Expanded(child: dialButton ?? Container()),
              Expanded(child: backspaceButton ?? Container()),
            ],
          );

    return KeypadFocusNode(
      onKeypadPressed: _onKeypadPressed,
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: widget.textFieldPadding,
              child: PhoneTextField(
                textStyle: TextStyle(
                  color: widget.dialOutputTextColor,
                  fontSize: widget.dialOutputTextSize * sizeFactor,
                ),
                decoration: InputDecoration(border: InputBorder.none, hintText: widget.hint),
                controller: _controller,
                copyToClipboard: widget.copyToClipboard,
                readOnly: !widget.pasteFromClipboard,
              ),
            ),
            Expanded(
              child: KeypadGrid(
                itemCount: 12,
                itemBuilder: (context, index) {
                  final key = _generator.get(index);
                  final altKey = _generator.getAlt(index);
                  final hint = _generator.hint(index);
                  return _keypadButtonBuilder(context, index, key, altKey, hint);
                },
                footer: footer,
              ),
            )
          ],
        ),
      ),
    );
  }
}