import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_challenge/page/blinds_page.dart';
import 'package:ui_challenge/page/flow_page.dart';
import 'package:ui_challenge/page/home_widget.dart';
import 'package:ui_challenge/page/map_page.dart';
import 'package:ui_challenge/page/parallax_motion_page.dart';
import 'package:ui_challenge/page/round_satellite_btn_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'clip_img_page.dart';

/// File Description:
/// Author: HJ2023011
/// Date: 2023/10/10
/// 善战者无赫赫之功，善医者无煌煌之名

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> buttonNames = [
    "MIRROR_CLOCK",
    "PARALLAX_IMG",
    "BLINDS_BANNER",
    "CLIP_IMG_BANNER",
    "SATELLITE_BTN",
    "FLOW_LAYOUT",
    "MAP_SVG",
    "COMING_SOON"
  ];

  bool dogeShow = false;
  Offset? mouseOffset;
  double moveType = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MouseRegion(
        onEnter: (e) {
          setState(() {
            dogeShow = true;
            mouseOffset = e.position;
          });
        },
        onHover: (e) {
          setState(() {
            if (e.position.dx - (mouseOffset?.dx ?? 0) > 0) {
              moveType = -1.0;
            } else {
              moveType = 1.0;
            }
            mouseOffset = e.position;
          });
        },
        onExit: (_) {
          setState(() {
            dogeShow = false;
          });
        },
        child: Stack(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 80,
                        width: 80,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          foregroundImage: AssetImage("asset/image/header.jpg"),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Sun.star",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        """may be a good man
                      coding monkey of Flutter and Android
                      location : Shijiazhuang City, Hebei 
                      this is my ui challenge website
                      Welcome""",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      const Text(
                        "project home : ",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      MaterialButton(
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          highlightElevation: 0,
                          splashColor: Colors.transparent,
                          textColor: Colors.blue,
                          onPressed: () {
                            launchUrl(Uri.parse(
                                "https://github.com/SunStarJ/ui_challenge"));
                          },
                          child: const Text(
                            "https://github.com/SunStarJ/ui_challenge",
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ))
                    ],
                  ),
                )),
                SizedBox(
                  width: 20,
                ),
                VerticalDivider(
                  color: Color(0XFFE5E5E5),
                ),
                SizedBox(
                  width: 20,
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
                                case 3:
                                  widget = const KeyBoardImgPage();
                                  break;
                                case 4:
                                  widget = const RoundSatellitePage();
                                  break;
                                case 5:
                                  widget = FlowPage();
                                  break;
                                case 6:
                                  widget = const MapSvgPage();
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
            dogeShow
                ? Positioned(
                    left: mouseOffset?.dx == null ? 0 : (mouseOffset!.dx + 10),
                    top: mouseOffset?.dy == null ? 0 : (mouseOffset!.dy + 10),
                    width: 50,
                    height: 50,
                    child: Transform(
                      transform: Matrix4.identity()..scale(moveType, 1, 1),
                      child: Gif(
                        image: AssetImage("asset/image/doge.gif"),
                        autostart: Autostart.loop,
                        duration: Duration(milliseconds: 200),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 0,
                    width: 0,
                  )
          ],
        ),
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
