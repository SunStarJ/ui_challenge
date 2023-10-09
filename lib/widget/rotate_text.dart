import 'package:flutter/cupertino.dart';

/// File Description:
/// Author: HJ2023011
/// Date: 2023/10/9
/// 善战者无赫赫之功，善医者无煌煌之名

class RotateTextWidget extends StatefulWidget {
  String text;
  TextStyle? textStyle;
  double rotateDegree;
  Duration? duration;

  RotateTextWidget(
      {super.key,
      required this.text,
      this.rotateDegree = 0,
      required this.textStyle,
      this.duration});

  @override
  State<RotateTextWidget> createState() => RotateTextWidgetState();
}

class RotateTextWidgetState extends State<RotateTextWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: widget.rotateDegree,
      duration: widget.duration ?? const Duration(milliseconds: 500),
      child: AnimatedDefaultTextStyle(
        duration: widget.duration ?? const Duration(milliseconds: 500),
        style: widget.textStyle ?? const TextStyle(),
        child: Text(widget.text),
      ),
    );
  }
}
