import 'package:flutter/cupertino.dart';

/// File Description:
/// Author: HJ2023011
/// Date: 2023/10/13
/// 善战者无赫赫之功，善医者无煌煌之名

class SatelliteItemWidget extends StatelessWidget {
  Widget child;
  Offset offset;

  SatelliteItemWidget({super.key, required this.child, required this.offset});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: child,
      left: offset.dx,
      top: offset.dy,
    );
  }
}
