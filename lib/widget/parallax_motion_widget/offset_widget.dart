import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// File Description:
/// Author: HJ2023011
/// Date: 2023/10/10
/// 善战者无赫赫之功，善医者无煌煌之名

class ControllerOffsetWidget extends StatefulWidget {
  Widget child;
  ScrollController controller;

  ControllerOffsetWidget(
      {super.key, required this.controller, required this.child});

  @override
  State<ControllerOffsetWidget> createState() => ControllerOffsetWidgetState();
}

class ControllerOffsetWidgetState extends State<ControllerOffsetWidget> {
  GlobalKey key = GlobalKey();
  double floatX = 0;
  double floatY = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400,
          child: OffsetWidget(
            key: key,
            child: widget.child,
            floatY: floatY,
          ),
        ),
        MaterialButton(onPressed: () {})
      ],
    );
  }

  void positionChange() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      double windowHeight = MediaQuery.of(context).size.height;
      RenderBox box = key.currentContext?.findRenderObject() as RenderBox;
      if (box == null) return;
      Offset offset = box.localToGlobal(Offset.zero);
      if (windowHeight < offset.dy) {
        return;
      }
      double difY = windowHeight - offset.dy;
      floatY = -difY/2;
      setState(() {});
    });
  }
}

class OffsetWidget extends StatelessWidget {
  Widget child;
  double floatX;
  double floatY;

  OffsetWidget(
      {super.key, required this.child, this.floatX = 0, this.floatY = 0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (ctx, size) => Stack(
              clipBehavior: Clip.antiAlias,
              children: [
                Positioned(
                  top: floatY,
                  left: floatX,
                  width: size.maxWidth,
                  child: child,
                )
              ],
            ));
  }
}
