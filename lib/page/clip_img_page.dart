import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_challenge/widget/clip_img_widget.dart';

/// File Description:
/// Author: HJ2023011
/// Date: 2023/10/12
/// 善战者无赫赫之功，善医者无煌煌之名

class KeyBoardImgPage extends StatefulWidget {
  const KeyBoardImgPage({super.key});

  @override
  State<KeyBoardImgPage> createState() => _KeyBoardImgPageState();
}

class _KeyBoardImgPageState extends State<KeyBoardImgPage> {
  Offset? middlePont ;

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
              child: Center(
            child: MouseRegion(
              onHover: (e) {
                setState(() {
                  middlePont = e.position;
                });
              },
              onEnter: (e) {
                setState(() {
                  middlePont = e.position;
                });
              },
              onExit: (e) {
              },
              child: SizedBox(
                height: 500,
                child: Stack(
                  children: [
                    Container(
                      child: Image.asset(
                        "asset/image/phone_white.png",
                      ),
                      width: double.infinity,
                    ),
                    ClipImg(
                        middlePoint: middlePont,
                        child: Container(
                          child: Image.asset(
                            "asset/image/phone_black.png",
                          ),
                          width: double.infinity,
                        ))
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
