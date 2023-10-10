import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_challenge/page/home_widget.dart';
import 'package:ui_challenge/page/parallax_motion_page.dart';

/// File Description:
/// Author: HJ2023011
/// Date: 2023/10/10
/// 善战者无赫赫之功，善医者无煌煌之名

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
              height: 40,
              child: MoveWindow(
                child: Container(),
              )),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MaterialButton(
                    onPressed: () {
                      navigateToPage(context, const AppHomePage());
                    },
                    child: Text("时钟"),
                  ),
                  MaterialButton(
                      onPressed: () {
                        navigateToPage(context, const ParallaxMotionPage());
                      },
                      child: Text("视差动画")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToPage(BuildContext context, Widget child) {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => child));
  }
}
