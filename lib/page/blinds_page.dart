import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_challenge/widget/blinds_banner_widget/blinds_banner_widget.dart';

/// File Description:
/// Author: HJ2023011
/// Date: 2023/10/11
/// 善战者无赫赫之功，善医者无煌煌之名

class BlindsPage extends StatelessWidget {
  List<String> picList = [
    "https://t7.baidu.com/it/u=774679999,2679830962&fm=193&f=GIF",
    "https://t7.baidu.com/it/u=1856946436,1599379154&fm=193&f=GIF",
    "https://t7.baidu.com/it/u=1010739515,2488150950&fm=193&f=GIF",
    "https://t7.baidu.com/it/u=1314925964,1262561676&fm=193&f=GIF"
  ];

  BlindsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: 200,
          child: BlindsBannerWidget(
            animDuration: Duration(milliseconds: 500),
              builder: (ctx, index) => Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(picList[index],fit: BoxFit.cover,),
                    ),
                  ),
              length: 4),
        ),
      ),
    );
  }

  Color getRandomColor() {
    final Random random = Random();
    final int r = random.nextInt(256); // 0 to 255
    final int g = random.nextInt(256); // 0 to 255
    final int b = random.nextInt(256); // 0 to 255

    return Color.fromARGB(
        255, r, g, b); // Create a Color object with the random values
  }
}
