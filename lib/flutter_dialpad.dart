library flutter_dialpad;

import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
//import 'package:flutter_dtmf/flutter_dtmf.dart';

import 'dialbutton.dart';

class DialPad extends StatefulWidget {
  final ValueSetter<String> makeCall;
  final Color buttonColor;
  final Color buttonTextColor;
  final Color dialButtonColor;
  final Color dialButtonIconColor;
  final Color backspaceButtonIconColor;
  final String outputMask;
  DialPad(
      {this.makeCall,
        this.outputMask,
        this.buttonColor,
        this.buttonTextColor,
        this.dialButtonColor,
        this.dialButtonIconColor,
        this.backspaceButtonIconColor});

  @override
  _DialPadState createState() => _DialPadState();
}

class _DialPadState extends State<DialPad> {
  //var dtmf = DTMF();
  MaskedTextController textEditingController;
  var _value = "";
  var mainTitle = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "✳︎", "0", "＃"];
  var subTitle = [
    "",
    "ABC",
    "DEF",
    "GHI",
    "JKL",
    "MNO",
    "PQRS",
    "TUV",
    "WXYZ",
    "",
    "+",
    ""
  ];

  @override
  void initState() {
    textEditingController = MaskedTextController(
        mask: widget.outputMask != null ? widget.outputMask : '(000) 000-0000');
    super.initState();
  }

  _setText(String value) async {
    //await dtmf.playTone(value);
    setState(() {
      _value += value;
      textEditingController.text = _value;
    });
  }

  List<Widget> _getDialerButtons() {
    var rows = List<Widget>();
    var items = List<Widget>();
    for (var i = 0; i < mainTitle.length; i++) {

      if (i % 3 == 0 && i > 0) {
        rows.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: items));
        rows.add(SizedBox(height: 12,));
        items = List<Widget>();
      }

      items.add(DialButton(
        title: mainTitle[i],
        subtitle: subTitle[i],
        color: widget.buttonColor,
        textColor: widget.buttonTextColor,
        onTap: _setText,
      ));
    }
    //To Do: Fix this workaround for last row
    rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: items));
    rows.add(SizedBox(height: 12,));

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              style: TextStyle(color: Colors.white, fontSize: 40),
              textAlign: TextAlign.center,
              decoration: InputDecoration(border: InputBorder.none),
              controller: textEditingController,
            ),
          ),
          ..._getDialerButtons(),

          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Container(),
              ),
              Expanded(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      widget.makeCall(textEditingController.text);
                    },
                    child: DialButton(
                      icon: Icons.phone,
                      color: Colors.green,
                      onTap: (title) {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: IconButton(
                    icon: Icon(
                      Icons.backspace,
                      size: 40,
                      color: _value.length > 0
                          ? (widget.backspaceButtonIconColor != null
                          ? widget.backspaceButtonIconColor
                          : Colors.white24)
                          : Colors.white24,
                    ),
                    onPressed: _value.length == 0
                        ? null
                        : () {
                      if (_value != null && _value.length > 0) {
                        setState(() {
                          _value = _value.substring(0, _value.length - 1);
                          textEditingController.text = _value;
                        });
                      }
                    },
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
