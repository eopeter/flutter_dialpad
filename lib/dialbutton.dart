import 'dart:async';

import 'package:flutter/material.dart';


class DialButton extends StatefulWidget {
  final String title;
  final String subtitle;
  final Color color;
  final Color textColor;
  final IconData icon;
  final ValueSetter<String> onTap;

  DialButton(
      {this.title,
        this.subtitle,
        this.color,
        this.textColor,
        this.icon,
        this.onTap});

  @override
  _DialButtonState createState() => _DialButtonState();
}

class _DialButtonState extends State<DialButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _colorTween;
  Timer _timer;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _colorTween = ColorTween(
        begin: widget.color != null ? widget.color : Colors.white24,
        end: Colors.white)
        .animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // custom code here
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var sizeFactor = screenSize.height * 0.09852217;

    return GestureDetector(
      onTap: () {

        if (this.widget.onTap != null) this.widget.onTap(widget.title);

        if (_animationController.status == AnimationStatus.completed) {
          _animationController.reverse();
        } else {
          _animationController.forward();
          _timer = new Timer(const Duration(milliseconds: 200), () {
            setState(() {
              _animationController.reverse();
            });
          });
        }
      },
      child: ClipOval(
          child: AnimatedBuilder(
              animation: _colorTween,
              builder: (context, child) => Container(
                color: _colorTween.value,
                height: sizeFactor, // height of the button
                width: sizeFactor, // width of the button
                child: Center(
                    child: widget.icon == null
                        ? widget.subtitle != null
                        ? Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                  fontSize: sizeFactor / 2,
                                  color: widget.textColor != null
                                      ? widget.textColor
                                      : Colors.white),
                            )),
                        Text(widget.subtitle,
                            style: TextStyle(
                                color: widget.textColor != null
                                    ? widget.textColor
                                    : Colors.white))
                      ],
                    )
                        : Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: widget.title == "*" &&
                                  widget.subtitle == null
                                  ? screenSize.height * 0.0862069
                                  : sizeFactor / 2,
                              color: widget.textColor != null
                                  ? widget.textColor
                                  : Colors.white),
                        ))
                        : Icon(widget.icon,
                        size: sizeFactor / 2, color: Colors.white)),
              ))),
    );
  }
}
