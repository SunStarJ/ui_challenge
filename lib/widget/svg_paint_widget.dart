import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// File Description:
/// Author: HJ2023011
/// Date: 2023/10/17
/// 善战者无赫赫之功，善医者无煌煌之名

class SVGPinter extends StatefulWidget {
  List<SVGData> dataList;
  double height;
  ValueSetter<int>? indexChange;
  double width;

  SVGPinter(
      {super.key, required this.dataList, this.height = 200, this.width = 200,this.indexChange});

  @override
  State<SVGPinter> createState() => _SVGPinterState();
}

class _SVGPinterState extends State<SVGPinter> {
  Offset transformOffset = Offset(0, 0);
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: MouseRegion(
        onHover: _checkOnHover,
        child: CustomPaint(
          size: Size(widget.width, widget.height),
          painter: SvgPainter(widget.dataList,
              transformPosition: _changeOffset, scaleCallBack: _changeScale),
        ),
      ),
    );
  }

  void _changeScale(double scale) {
    this.scale = scale;
  }

  void _changeOffset(Offset offset) {
    transformOffset = offset;
    print("_changeOffset : ${transformOffset}");
  }

  void _checkOnHover(PointerHoverEvent event) {
    double hoverX = event.localPosition.dx;
    double hoverY = event.localPosition.dy;
    print("realX :$hoverX ,hoverY:$hoverY");
    double realX = (hoverX + transformOffset.dx) / scale;
    double realY = (hoverY + transformOffset.dy) / scale;

    widget.dataList.forEach((element) {
      if (element.paintPath.contains(Offset(realX, realY))) {
        int index = widget.dataList.lastIndexOf(element);

        // print("hover index ${index}");
        widget.indexChange?.call(index);
      }
    });
  }
}

class SvgPainter extends CustomPainter {
  List<SVGData> data;
  Paint svgPaint = Paint();
  Paint fillPaint = Paint();
  ValueSetter<Offset>? transformPosition;
  ValueSetter<double>? scaleCallBack;

  SvgPainter(this.data, {this.scaleCallBack, this.transformPosition});

  @override
  void paint(Canvas canvas, Size size) {
    print("size:${size}");
    double left = 0;
    double top = 0;
    double right = 0;
    double bottom = 0;
    data.forEach((data) {
      if (left == 0) left = data.minX;
      if (top == 0) top = data.minY;
      left = min(left, data.minX);
      top = min(top, data.minY);
      if (right == 0) right = data.maxX;
      if (bottom == 0) bottom = data.maxY;
      right = max(right, data.maxX);
      bottom = max(bottom, data.maxY);
    });

    double dx = right - left;
    double dy = bottom - top;
    double scaleX = size.width / dx;
    double scaleY = size.height / dy;
    double scale = min(scaleY, scaleX);
    transformPosition?.call(Offset(left * scale, top * scale));
    scaleCallBack?.call(scale);
    canvas.translate(-left * scale, -top * scale);
    print("top : ${top},left :${left},scale:${scale}");
    canvas.scale(scale);
    data.forEach((mapEntity) {
      fillPaint.color = mapEntity.fillColor;
      svgPaint
        ..strokeWidth = mapEntity.stokeWidth
        ..style = PaintingStyle.stroke
        ..color = mapEntity.stokeColor;
      canvas.drawPath(mapEntity.paintPath, fillPaint);
      canvas.drawPath(mapEntity.paintPath, svgPaint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class SVGData {
  String path;
  double stokeWidth;

  //初始缩放系数
  double initScaleX;

  double initScaleY;

  Color fillColor;

  Color stokeColor;

  double minX = 0;
  double minY = 0;
  double maxX = 0;
  double maxY = 0;

  late Path paintPath;

  SVGData({required this.path,
    this.fillColor = Colors.transparent,
    this.stokeColor = Colors.black,
    this.stokeWidth = 1.0,
    this.initScaleX = 1,
    this.initScaleY = 1}) {
    paintPath = generatePath();
  }

  Path generatePath() {
    String svgPath = this.path;
    Path paintPath = Path();
    int index = 0;
    int length = this.path.length;
    List<int> cmdPositionList = [];
    while (index < length) {
      String charResult = this.path.substring(index, index + 1);
      if (charResult.contains(RegExp(r'[A-z]'))) {
        cmdPositionList.add(index);
      }
      index++;
    }
    double lastPointX = 0;
    double lastPointY = 0;
    for (int i = 0; i < cmdPositionList.length; i++) {
      int cmdIndex = cmdPositionList[i];
      String pointString;
      if (i < cmdPositionList.length - 1) {
        pointString = svgPath.substring(cmdIndex + 1, cmdPositionList[i + 1]);
      } else {
        pointString = svgPath.substring(cmdIndex + 1, svgPath.length);
      }
      List<String> pointList = pointString.split(",");
      if (minX == 0) {
        minX = double.parse(pointList[0]);
      }
      if (maxX == 0) {
        maxX = double.parse(pointList[0]);
      }
      if (minY == 0) {
        minY = double.parse(pointList[1]);
      }
      if (maxY == 0) {
        maxY = double.parse(pointList[1]);
      }
      try {
        if (pointList.isNotEmpty) {
          minX = min(minX, double.parse(pointList[0]));
          maxX = max(maxX, double.parse(pointList[0]));
          minY = min(minY, double.parse(pointList[1]));
          maxY = max(maxY, double.parse(pointList[1]));
        }
      } catch (e) {}

      switch (svgPath.substring(cmdIndex, cmdIndex + 1)) {
        case 'm':
        case 'M':
          {
            lastPointX = double.parse(pointList[0]) * initScaleX;
            lastPointY = double.parse(pointList[1]) * initScaleY;
            paintPath.moveTo(lastPointX, lastPointY);
          }
          break;
        case "l":
        case "L":
          {
            lastPointX = double.parse(pointList[0]) * initScaleX;
            lastPointY = double.parse(pointList[1]) * initScaleY;
            paintPath.lineTo(lastPointX, lastPointY);
          }
          break;
        case 'h':
        case 'H':
          {
            lastPointX = double.parse(pointList[0]) * initScaleX;
            paintPath.lineTo(lastPointX, lastPointY);
          }
          break;
        case 'v':
        case 'V':
          {
            lastPointY = double.parse(pointList[0]) * initScaleY;
            paintPath.lineTo(lastPointX, lastPointY);
          }
          break;
        case 'c':
        case 'C':
          {
            //3次贝塞尔曲线
            lastPointX = double.parse(pointList[4]) * initScaleX;
            lastPointY = double.parse(pointList[5]) * initScaleY;
            paintPath.cubicTo(
                double.parse(pointList[0]) * initScaleX,
                double.parse(pointList[1]) * initScaleY,
                double.parse(pointList[2]) * initScaleX,
                double.parse(pointList[3]) * initScaleY,
                lastPointX,
                lastPointY);
          }
          break;
        case 's':
        case 'S':
          {
            paintPath.cubicTo(
                lastPointX,
                lastPointY,
                double.parse(pointList[0]) * initScaleX,
                double.parse(pointList[1]) * initScaleY,
                double.parse(pointList[2]) * initScaleX,
                double.parse(pointList[3]) * initScaleY);
            lastPointX = double.parse(pointList[2]) * initScaleX;
            lastPointY = double.parse(pointList[3]) * initScaleY;
          }
          break;
        case 'q':
        case 'Q':
          {
            lastPointX = double.parse(pointList[2]) * initScaleX;
            lastPointY = double.parse(pointList[3]) * initScaleY;
            paintPath.quadraticBezierTo(
                double.parse(pointList[0]) * initScaleX,
                double.parse(pointList[1]) * initScaleY,
                double.parse(pointList[2]) * initScaleX,
                double.parse(pointList[3]) * initScaleY);
          }

          break;
        case 't':
        case 'T':
          {
            paintPath.quadraticBezierTo(
                lastPointX,
                lastPointY,
                double.parse(pointList[0]) * initScaleX,
                double.parse(pointList[1]) * initScaleY);
            lastPointX = double.parse(pointList[0]) * initScaleX;
            lastPointY = double.parse(pointList[1]) * initScaleY;
          }
          break;
        case 'a':
        case 'A':
          {
            //画弧
          }
          break;
        case 'z':
        case 'Z':
          {
            paintPath.close();
          }
          break;
      }
    }
    return paintPath;
  }
}
