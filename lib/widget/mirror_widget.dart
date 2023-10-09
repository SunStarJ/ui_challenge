import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// File Description:
/// Author: HJ2023011
/// Date: 2023/10/9
/// 善战者无赫赫之功，善医者无煌煌之名

class MirrorWidget extends StatelessWidget {
  Widget child;

  MirrorWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0, 0.3, 1],
              colors: [
                Colors.white.withOpacity(.6),
                Colors.white.withOpacity(.1),
                Colors.transparent,
              ],
            ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
          },
          blendMode: BlendMode.srcIn,
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(1.0, -1, 1),
            child: child,
          ),
        ),
      ),
    );
  }
}
