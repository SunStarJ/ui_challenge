import 'dart:async';

import 'package:flutter/cupertino.dart';

/// File Description:
/// Author: HJ2023011
/// Date: 2023/10/11
/// 善战者无赫赫之功，善医者无煌煌之名

class BlindsBannerWidget extends StatefulWidget {
  NullableIndexedWidgetBuilder builder;
  int length;
  Duration? animDuration;
  Duration? preItemWaitDuration;
  Axis direction;
  int curIndex;
  double spaceWidth;

  BlindsBannerWidget(
      {super.key,
      required this.builder,
      required this.length,
      this.animDuration,
      this.preItemWaitDuration,
      this.direction = Axis.horizontal,
      this.curIndex = 0,
      this.spaceWidth = 10});

  @override
  State<BlindsBannerWidget> createState() => _BlindsBannerWidgetState();
}

class _BlindsBannerWidgetState extends State<BlindsBannerWidget> {
  int curIndex = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    curIndex = widget.curIndex;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      timer = Timer.periodic(widget.preItemWaitDuration ?? Duration(seconds: 3),
          (t) {
        if (curIndex == widget.length - 1) {
          curIndex = 0;
        } else {
          curIndex += 1;
        }
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, size) {
      return widget.direction == Axis.vertical
          ? Column(
              children: generateWidgetList(context, size),
            )
          : Row(
              children: generateWidgetList(context, size),
            );
    });
  }

  List<Widget> generateWidgetList(BuildContext context, BoxConstraints size) {
    List<Widget> widgetList = [];
    for (int i = 0; i < widget.length; i++) {
      if (curIndex == i) {
        widgetList
            .add(majorWidget(size, widget.builder(context, i) ?? Container()));
      } else {
        widgetList
            .add(minorWidget(size, widget.builder(context, i) ?? Container()));
      }
      if (i != widget.length - 1) {
        widgetList.add(SizedBox(
          width: widget.spaceWidth,
          height: widget.spaceWidth,
        ));
      }
    }
    return widgetList;
  }

  Widget majorWidget(BoxConstraints size, Widget child) {
    double majorHeight = size.maxHeight * 3 / 4;
    double majorWidth = size.maxWidth * 3 / 4;
    return AnimatedContainer(
        height:
            widget.direction == Axis.horizontal ? double.infinity : majorHeight,
        width: widget.direction == Axis.vertical ? double.infinity : majorWidth,
        duration: widget.animDuration ?? const Duration(milliseconds: 200),
        child: ClipRect(
          clipBehavior: Clip.antiAlias,
          child: child,
        ));
  }

  Widget minorWidget(BoxConstraints size, Widget child) {
    int length = widget.length; // 获取总个数
    double spaceWidth = (length - 1) * widget.spaceWidth; // 根据总个数获取空白总宽度
    double balanceWidth = size.maxWidth / 4 - spaceWidth; // 根据空白总宽度获取剩余总宽度
    double balanceHeight = size.maxHeight / 4 - spaceWidth; // 根据空白总宽度获取剩余总
    double preItemWidth = balanceWidth / (widget.length - 1);
    double preItemHeight = balanceHeight / (widget.length - 1);
    return AnimatedContainer(
      height:
          widget.direction == Axis.horizontal ? double.infinity : preItemHeight,
      width: widget.direction == Axis.vertical ? double.infinity : preItemWidth,
      duration: widget.animDuration ?? const Duration(milliseconds: 200),
      child: ClipRect(
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }
}
