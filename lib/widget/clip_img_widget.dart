import 'dart:math';

import 'package:flutter/cupertino.dart';

/// File Description:
/// Author: HJ2023011
/// Date: 2023/10/12
/// 善战者无赫赫之功，善医者无煌煌之名
///
///

class ClipImg extends StatefulWidget {
  Widget child;
  Offset? middlePoint;

  ClipImg({super.key, required this.child, this.middlePoint});

  @override
  State<ClipImg> createState() => _ClipImgState();
}

class _ClipImgState extends State<ClipImg> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ImageClip(widget.middlePoint),
      child: widget.child,
    );
  }
}

class ImageClip extends CustomClipper<Path> {
  Offset? middlePoint;

  ImageClip(this.middlePoint);

  @override
  Path getClip(Size size) {
    Path myPath = Path();
    if (middlePoint == null) {
      middlePoint = Offset(size.width, size.height);
      myPath.moveTo(0, 0);
      myPath
        ..lineTo(size.width, 0)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..close();
    } else {
      myPath.moveTo(0, 0);
      myPath
        ..lineTo(middlePoint!.dx + 100, 0)
        ..lineTo(middlePoint!.dx - 100, size.height)
        ..lineTo(0, size.height)
        ..close();
    }
    return myPath;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
