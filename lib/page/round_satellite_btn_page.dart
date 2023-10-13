import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_challenge/widget/round_satellite_widget/satellite_widget.dart';

/// File Description:
/// Author: HJ2023011
/// Date: 2023/10/13
/// 善战者无赫赫之功，善医者无煌煌之名

class RoundSatellitePage extends StatefulWidget {
  const RoundSatellitePage({super.key});

  @override
  State<RoundSatellitePage> createState() => _RoundSatellitePageState();
}

class _RoundSatellitePageState extends State<RoundSatellitePage>
    with SingleTickerProviderStateMixin {
  GlobalKey<SatelliteWidgetState> key = GlobalKey();
  AnimationStatus? state;
  late AnimationController controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 300))
        ..addListener(() {
          setState(() {});
        })
        ..addStatusListener((status) {
          state = status;
        });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          height: kToolbarHeight,
          child: MoveWindow(
            child: AppBar(),
          ),
        ),
      ],),
      floatingActionButton: SatelliteWidget(
          key: key,
          radius: 100,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOutBack,
          children: [
            FloatingActionButton(
              mini: true,
              onPressed: () {},
              child: Icon(Icons.list),
            ),
            FloatingActionButton(
              mini: true,
              onPressed: () {},
              child: Icon(Icons.padding),
            ),
            FloatingActionButton(
              mini: true,
              onPressed: () {},
              child: Icon(Icons.headphones),
            ),
            FloatingActionButton(
              mini: true,
              onPressed: () {},
              child: Icon(Icons.ac_unit),
            ),
          ],
          child: FloatingActionButton(
            onPressed: () {
              if (state == null || state == AnimationStatus.dismissed) {
                controller.forward();
              } else {
                controller.reverse();
              }
              key.currentState?.toggle();
            },
            child: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: AlwaysStoppedAnimation<double>(controller.value)),
            mini: true,
          )),
    );
  }
}
