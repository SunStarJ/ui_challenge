import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// File Description:
/// Author: HJ2023011
/// Date: 2023/10/16
/// 善战者无赫赫之功，善医者无煌煌之名

class FlowLayoutEx extends StatefulWidget {
  List<Widget> children;
  int maxLines;
  Widget? moreWidget;

  FlowLayoutEx(
      {super.key, required this.children, this.maxLines = 0, this.moreWidget});

  @override
  State<FlowLayoutEx> createState() => FlowLayoutExState();
}

class FlowLayoutExState extends State<FlowLayoutEx> {
  bool unlimited = false;
  double height = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flow(
          key: UniqueKey(),
          delegate: MyFlowDelegate(
              widget.maxLines, widget.moreWidget != null, unlimited, (height) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              if (this.height != height) {
                setState(() {
                  this.height = height;
                  print("this.height ${this.height}");
                });
              }
            });
          }, sizeHeight: height),
          children: [
            ...widget.children,
            widget.moreWidget ??
                const SizedBox(
                  height: 0,
                )
          ],
        ),
      ],
    );
  }

  void showMore() {
    setState(() {
      unlimited = true;
    });
  }

  void hideMore() {
    setState(() {
      unlimited = false;
    });
  }

  void toggle() {
    setState(() {
      unlimited = !unlimited;
    });
  }
}

class MyFlowDelegate extends FlowDelegate {
  int maxLines = 0;
  bool showMoreWidget;
  bool unlimited;
  double widgetHeight = 0;
  ValueChanged<double> heightCalculate;
  double sizeHeight;

  MyFlowDelegate(
      this.maxLines, this.showMoreWidget, this.unlimited, this.heightCalculate,
      {required this.sizeHeight});

  @override
  void paintChildren(FlowPaintingContext context) {
    print("paintChildren");
    var x = 0.0; // 绘制坐标
    var y = 0.0;
    double lineHeight = 0.0; // 行高
    double curLine = 0; // 当前行

    for (var i = 0; i < context.childCount; i++) {
      if (curLine < maxLines && showMoreWidget && i == context.childCount - 1) {
        // 如果根本就没到最后一行 而且最后一个是更多按钮 那就没必要画了
        break;
      }
      if (maxLines == 0 && showMoreWidget && i == context.childCount - 1) {
        // 如果没有限制最大行数 且还又更多按钮也就没必要画了
        break;
      }
      //轮询数据
      double w = context.getChildSize(i)?.width ?? 0; // 当前widget 宽度
      double h = context.getChildSize(i)?.height ?? 0; // 当前widget 高度
      double moreWidgetWidth = 0; // 更多按钮高度
      if (showMoreWidget) {
        // 如果显示更多按钮
        moreWidgetWidth =
            context.getChildSize(context.childCount - 1)?.width ?? 0; //获取更多按钮宽度
      }
      lineHeight = max(h, lineHeight); // 计算行高
      if (unlimited) {
        if (x + w > context.size.width) {
          // If the next widget doesn't fit in the current row, move to the next row
          x = 0;
          y += lineHeight + 10; // Add spacing between rows
          curLine += 1;
          print("check curLine : $curLine");
        }
        x = paintOriginLine(x, w, context, y, lineHeight, curLine, i);
        x += w + 10; // Add spacing between children
        continue;
      }
      if (maxLines != 0 && curLine >= maxLines - 1) {
        if (x + w + moreWidgetWidth > context.size.width) {
          // 如果当前标签 + 最后按钮宽度 > 行宽
          // 首先判定 当前按钮绘制宽度会不会超过 且是不是最后一个按钮
          if (x + w < context.size.width && i == context.childCount - 2) {
            // 如果标签本身宽度小于组件宽度 且是最后一个组件
            paintOriginItem(context, i, x, y);
            // 画完就不需要画更多按钮了
            break;
          } else {
            // 如果组件非最后一个 或者 长度本身已经超过了宽度那么只需要绘制更多按钮就好了
            paintMoreWidget(context, x, y);
            break;
          }
        } else {
          paintOriginItem(context, i, x, y);
        }
      } else {
        if (x + w > context.size.width) {
          x = 0;
          y += lineHeight + 10;
          curLine += 1;
          print("check curLine : $curLine");
        }
        x = paintOriginLine(x, w, context, y, lineHeight, curLine, i);
      }
      x += w + 10; // Add spacing between children
    }
    widgetHeight = y + lineHeight;
    print("widgetHeight ${widgetHeight}");
    heightCalculate.call(widgetHeight);
  }

  @override
  Size getSize(BoxConstraints constraints) {
    print("sizeHeight ${sizeHeight}");
    return Size(double.infinity, sizeHeight);
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return true;
  }

  void paintOriginItem(FlowPaintingContext context, int i, double x, double y) {
    context.paintChild(
      i,
      transform: Matrix4.translationValues(x, y, 0.0),
    );
  }

  void paintMoreWidget(FlowPaintingContext context, double x, double y) {
    context.paintChild(
      context.childCount - 1,
      transform: Matrix4.translationValues(x, y, 0.0),
    );
  }

  double paintOriginLine(double x, double w, FlowPaintingContext context,
      double y, double lineHeight, double curLine, int i) {
    paintOriginItem(context, i, x, y);
    return x;
  }
}
