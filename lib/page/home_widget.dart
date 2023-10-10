import 'dart:math';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_challenge/data/number_select_data.dart';
import 'package:ui_challenge/provider/hour_provider.dart';
import 'package:ui_challenge/widget/mirror_widget.dart';
import 'package:ui_challenge/widget/num_select_item.dart';
import 'package:ui_challenge/widget/rotate_text.dart';

import '../provider/time_minutes_provider.dart';
import '../provider/time_second_provider.dart';
import '../widget/second_item.dart';

/// File Description:
/// Author: HJ2023011
/// Date: 2023/10/9
/// 善战者无赫赫之功，善医者无煌煌之名

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  int curIndex = 0;

  List<NumberSelectData> secondList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
      .map((e) => NumberSelectData(e, isSelect: e == 0))
      .toList();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SecondProvider()),
        ChangeNotifierProvider(create: (_) => HourProvider()),
        ChangeNotifierProvider(create: (_) => MinutesProvider())
      ],
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0XFFFDD1EC), Color(0XFFE13B90)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight)),
            ),
            SizedBox(
                height: 60,
                child: MoveWindow(
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios,color: Colors.white,))
                      ],
                    ),
                  ),
                )),
            Center(
              child: _HomePageBody(),
            )
          ],
        ),
      ),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ClockWidget(),
        SizedBox(
          height: 10,
        ),
        Container(
          child: MirrorWidget(child: _ClockWidget()),
        )
      ],
    );
  }
}

class _ClockWidget extends StatelessWidget {
  const _ClockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Spacer(),
        HourItem(),
        Text(
          "时",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        MinutesItem(),
        Text(
          "分",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SecondItem(),
        Text(
          "秒",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        _TimeSpacer()
      ],
    );
  }
}

class _TimeSpacer extends StatelessWidget {
  const _TimeSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    SecondProvider secondProvider = context.read();
    HourProvider hourProvider = context.read();
    MinutesProvider minutesProvider = context.read();
    return StreamBuilder(
        stream: Stream.periodic(Duration(seconds: 1), (i) => i),
        builder: (context, snapshot) {
          DateTime currentTime = DateTime.now();
          hourProvider.changeTime(currentTime.hour.toString());
          minutesProvider.changeTime(currentTime.minute.toString());
          secondProvider.changeTime(currentTime.second.toString());
          return const Spacer();
        });
  }
}
