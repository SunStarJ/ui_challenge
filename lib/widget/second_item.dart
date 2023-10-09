import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:ui_challenge/provider/time_minutes_provider.dart';

import '../provider/hour_provider.dart';
import '../provider/time_second_provider.dart';
import 'num_select_item.dart';

/// File Description:
/// Author: HJ2023011
/// Date: 2023/10/9
/// 善战者无赫赫之功，善医者无煌煌之名

class SecondItem extends StatelessWidget {
  const SecondItem({super.key});

  @override
  Widget build(BuildContext context) {
    SecondProvider provider = context.watch();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children:
            provider.tenthList.map((e) => NumSelectItem(data: e)).toList(),
          ),
          SizedBox(width: 30,),
          Column(
            mainAxisSize: MainAxisSize.min,
            children:
            provider.onesList.map((e) => NumSelectItem(data: e)).toList(),
          )
        ],
      ),
    );
  }
}

class MinutesItem extends StatelessWidget {
  const MinutesItem({super.key});

  @override
  Widget build(BuildContext context) {
    MinutesProvider provider = context.watch();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children:
            provider.tenthList.map((e) => NumSelectItem(data: e)).toList(),
          ),
          SizedBox(width: 30,),
          Column(
            mainAxisSize: MainAxisSize.min,
            children:
            provider.onesList.map((e) => NumSelectItem(data: e)).toList(),
          )
        ],
      ),
    );
  }
}


class HourItem extends StatelessWidget {
  const HourItem({super.key});

  @override
  Widget build(BuildContext context) {
    HourProvider provider = context.watch();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children:
          provider.tenthList.map((e) => NumSelectItem(data: e)).toList(),
        ),
        SizedBox(width: 30,),
        Column(
          mainAxisSize: MainAxisSize.min,
          children:
          provider.onesList.map((e) => NumSelectItem(data: e)).toList(),
        )
      ],
    ),);
  }
}
