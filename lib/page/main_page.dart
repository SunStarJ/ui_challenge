import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_challenge/page/blinds_page.dart';
import 'package:ui_challenge/page/home_widget.dart';
import 'package:ui_challenge/page/parallax_motion_page.dart';

/// File Description:
/// Author: HJ2023011
/// Date: 2023/10/10
/// 善战者无赫赫之功，善医者无煌煌之名

class MainPage extends StatelessWidget {
  List<String> buttonNames = [
    "MIRROR_CLOCK",
    "PARALLAX_IMG",
    "BLINDS_BANNER",
    "COMING_SOON"
  ];

  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0XFFFDE2EB),
              Color(0XFFF09DAF),
            ])),
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                alignment: Alignment.centerRight,
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        foregroundImage: AssetImage("asset/image/header.jpg"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Sun.star",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      """may be a good man
                    coding monkey of Flutter and Android
                    location : Shijiazhuang City, Hebei 
                    this is my ui challenge website
                    Welcome""",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.end,
                    )
                  ],
                ),
              )),
              SizedBox(
                width: 20,
              ),
              VerticalDivider(
                color: Color(0XFFE5E5E5),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) => HoverButton(
                          name: buttonNames[index],
                          onPress: () {
                            Widget? widget;
                            switch (index) {
                              case 0:
                                widget = const AppHomePage();
                                break;
                              case 1:
                                widget = const ParallaxMotionPage();
                                break;
                              case 2:
                                widget = BlindsPage();
                                break;
                            }
                            if (widget != null) {
                              navigateToPage(context, widget);
                            }
                          }),
                      itemCount: buttonNames.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 10,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void navigateToPage(BuildContext context, Widget child) {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => child));
  }
}

class HoverButton extends StatefulWidget {
  String name;
  VoidCallback onPress;

  HoverButton({super.key, required this.name, required this.onPress});

  @override
  State<HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
          onTap: widget.onPress,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: AnimatedDefaultTextStyle(
                child: Text(widget.name),
                style: GoogleFonts.sono(
                    fontSize: !isHover ? 20 : 40, color: Colors.white),
                duration: Duration(milliseconds: 200)),
          )),
      onEnter: (_) {
        setState(() {
          if (!isHover) {
            isHover = true;
          }
        });
      },
      onExit: (_) {
        setState(() {
          if (isHover) {
            isHover = false;
          }
        });
      },
    );
  }
}
