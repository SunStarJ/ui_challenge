import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_challenge/widget/round_satellite_widget/satellite_item_widget.dart';

/// File Description:
/// Author: HJ2023011
/// Date: 2023/10/13
/// 善战者无赫赫之功，善医者无煌煌之名

class SatelliteWidget extends StatefulWidget {
  List<Widget> children = [];
  Widget child;
  double radius;
  int startDegree;
  Duration? duration;
  Curve? curve;

  SatelliteWidget(
      {super.key,
      required this.children,
      required this.child,
      this.radius = 50,
      this.duration,
      this.curve,
      this.startDegree = 0});

  @override
  State<SatelliteWidget> createState() => SatelliteWidgetState();
}

class SatelliteWidgetState extends State<SatelliteWidget>
    with SingleTickerProviderStateMixin {
  GlobalKey widgetKey = GlobalKey();
  AnimationStatus? state;
  late AnimationController animationController = AnimationController(
    vsync: this,
    duration: widget.duration ?? Duration(milliseconds: 300),
  )
    ..addListener(() {
      setState(() {});
    })
    ..addStatusListener((status) {
      state = status;
      print(status);
    });
  late Animation<double> anim = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: animationController,
          curve: widget.curve ?? Curves.easeInOutCubic))
    ..addListener(() {
      print(anim.value);
    });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        clipBehavior: Clip.none,
        key: widgetKey,
        alignment: Alignment.center,
        children: addChild([
          Padding(
            padding: EdgeInsets.all(widget.radius),
            child: widget.child,
          ),
        ]),
      ),
    );
  }

  List<Widget> addChild(List<Widget> children) {
    for (int i = 0; i < widget.children.length; i++) {
      children.insert(
          0,
          Visibility(
            visible: anim.value != 0,
            child: SatelliteItemWidget(
                child: widget.children[i],
                offset: calculateOffsetOfWidgetIndex(i)),
          ));
    }
    return children;
  }

  Offset calculateOffsetOfWidgetIndex(int index) {
    double degree = (index * (45)) - widget.startDegree.toDouble();
    double dx = widget.radius * cos(pi / 180 * degree);
    double dy = widget.radius * sin(pi / 180 * degree);
    Offset offset = Offset(
        (widget.radius - dx * anim.value), (widget.radius - dy * anim.value));
    return offset;
  }

  Size calculateSizeWidget() {
    RenderBox box = widgetKey.currentContext!.findRenderObject() as RenderBox;
    return box.size;
  }

  void toggle() {
    if (state == null || state == AnimationStatus.dismissed) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }
}
