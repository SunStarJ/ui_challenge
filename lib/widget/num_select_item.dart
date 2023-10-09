import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_challenge/widget/rotate_text.dart';

import '../data/number_select_data.dart';

/// File Description:
/// Author: HJ2023011
/// Date: 2023/10/9
/// 善战者无赫赫之功，善医者无煌煌之名

class NumSelectItem extends StatefulWidget {
  NumberSelectData data;

  NumSelectItem({super.key, required this.data});

  @override
  State<NumSelectItem> createState() => _NumSelectItemState();
}

class _NumSelectItemState extends State<NumSelectItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotateTextWidget(
            text: widget.data.number.toString(),
            textStyle: GoogleFonts.agdasima(
                textStyle: TextStyle(
                    fontSize: widget.data.isSelect ? 60 : 14,
                    fontWeight: FontWeight.bold,
                    color: widget.data.isSelect
                        ? Colors.white
                        : Colors.white30)),
            rotateDegree: widget.data.isSelect ? 0 : -1 / 4,
            duration: Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
