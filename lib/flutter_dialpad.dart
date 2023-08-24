library flutter_dialpad;

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import 'src/flutter_dialpad.dart';

export 'src/flutter_dialpad.dart';

class DialPad extends StatefulWidget {
  final ValueSetter<String>? makeCall;
  final ValueSetter<String>? keyPressed;
  final bool? hideDialButton;
  final bool? hideSubtitle;
  // buttonColor is the color of the button on the dial pad. defaults to Colors.gray
  final Color? buttonColor;
  final Color? buttonTextColor;
  final Color? dialButtonColor;
  final Color? dialButtonIconColor;
  final IconData? dialButtonIcon;
  final Color? backspaceButtonIconColor;
  final Color? dialOutputTextColor;
  // outputMask is the mask applied to the output text. Defaults to (000) 000-0000
  final String? outputMask;
  final bool? enableDtmf;

  DialPad(
      {this.makeCall,
      this.keyPressed,
      this.hideDialButton,
      this.hideSubtitle = false,
      this.outputMask,
      this.buttonColor,
      this.buttonTextColor,
      this.dialButtonColor,
      this.dialButtonIconColor,
      this.dialButtonIcon,
      this.dialOutputTextColor,
      this.backspaceButtonIconColor,
      this.enableDtmf});

  @override
  _DialPadState createState() => _DialPadState();
}

class _DialPadState extends State<DialPad> {
  MaskedTextController? textEditingController;
  var _value = "";

  @override
  void initState() {
    textEditingController = MaskedTextController(
        mask: widget.outputMask != null ? widget.outputMask : '(000) 000-0000');
    super.initState();
  }

  /// Handles keypad button press, this includes numbers and [DialActionKey] except [DialActionKey.backspace]
  void _onKeyPressed(String? value) {
    if (value != null) {
      setState(() {
        _value += value;
        textEditingController?.text = _value;
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
      textEditingController!.text = _value;
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
    } else {
      // For numbers, and all actions except backspace
      _onKeyPressed(key.value);
    }
  }

  Widget _defaultDialButtonBuilder(BuildContext context, int index, KeyValue key, KeyValue? altKey, String? hint) {
    return DialButton(
      title: key.value,
      subtitle: altKey?.value ?? hint,
      color: widget.buttonColor ?? Colors.grey,
      hideSubtitle: widget.hideSubtitle ?? false,
      onTap: _onKeyPressed,
      buttonType: ButtonType.circle,
      padding: const EdgeInsets.all(12),
      textColor: widget.buttonTextColor ?? Colors.black,
      iconColor: widget.buttonTextColor ?? Colors.black,
      subtitleIconColor: widget.buttonTextColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var sizeFactor = screenSize.height * 0.09852217;

    final _dialButtonBuilder = /*widget.buttonBuilder ?? */_defaultDialButtonBuilder;
    final _generator = PhoneKeypadGenerator();

    /// Dial button
    final dialButton = ActionButton(
      padding: const EdgeInsets.all(12),
      buttonType: ButtonType.circle,
      icon: widget.dialButtonIcon ?? Icons.phone,
      iconColor: widget.dialButtonIconColor ?? Colors.white,
      color: widget.dialButtonColor ?? Colors.green,
      onTap: _onDialPressed,
      disabled: _value.isEmpty,
    );

    /// Backspace button
    final backspaceButton = ActionButton(
      onTap: _onBackspacePressed,
      disabled: _value.isEmpty,
      buttonType: ButtonType.circle,
      iconSize: 75,
      iconColor: widget.backspaceButtonIconColor ?? Colors.grey,
      padding: const EdgeInsets.all(12),
      icon: Icons.backspace,
      color: Colors.transparent,
    );

    /// Footer contains the dial and backspace buttons
    final footer = Row(
      children: [
        Expanded(child: Container()),
        Expanded(child: dialButton),
        Expanded(child: backspaceButton),
      ],
    );

    return KeypadFocusNode(
      onKeypadPressed: _onKeypadPressed,
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: PhoneTextField(
                readOnly: true,
                textStyle: TextStyle(
                    color: widget.dialOutputTextColor ?? Colors.black,
                    fontSize: sizeFactor / 2),
                decoration: InputDecoration(border: InputBorder.none),
                controller: textEditingController,
              ),
            ),
            Expanded(
              child: KeypadGrid(
                itemCount: 12,
                itemBuilder: (context, index) {
                  final key = _generator.get(index);
                  final altKey = _generator.getAlt(index);
                  final hint = _generator.hint(index);
                  return _dialButtonBuilder(context, index, key, altKey, hint);
                },
                footer: footer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}