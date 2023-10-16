import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_challenge/widget/flow_layout/flow_layout_ex.dart';

/// File Description:
/// Author: HJ2023011
/// Date: 2023/10/16
/// 善战者无赫赫之功，善医者无煌煌之名

class FlowPage extends StatelessWidget {
  GlobalKey<FlowLayoutExState> flowLayoutKey = GlobalKey();

  FlowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: kToolbarHeight,
            child: MoveWindow(
              child: AppBar(),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                FlowLayoutEx(
                  key: flowLayoutKey,
                  maxLines: 3,
                  moreWidget: SizedBox(
                    height: 20,
                    child: GestureDetector(
                      child: const Text("展开"),
                      onTap: () {
                        flowLayoutKey.currentState?.toggle();
                      },
                    ),
                  ),
                  children: List.filled(
                      30,
                      Container(
                        child: Text("测试标签"),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.blueAccent, width: 1)),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
