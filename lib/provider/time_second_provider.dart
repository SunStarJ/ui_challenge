import 'package:flutter/cupertino.dart';

import '../data/number_select_data.dart';

/// File Description:
/// Author: HJ2023011
/// Date: 2023/10/9
/// 善战者无赫赫之功，善医者无煌煌之名

class SecondProvider extends ChangeNotifier {
  final List<int> _numList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  final List<int> _tenthNumList = [0, 1, 2, 3, 4, 5, 6];
  String _curTime = "0";
  int _curTimeSecondOnesDigit = 0;
  int _curTimeSecondTenthPlace = 0;
  late List<NumberSelectData> _tenthList;
  late List<NumberSelectData> _onesList;

  SecondProvider() {
    _tenthList = _tenthNumList.map((e) => NumberSelectData(e)).toList();
    _onesList = _numList.map((e) => NumberSelectData(e)).toList();
  }

  void changeTime(String second) {
    String changeSecond = second;
    if(second == _curTime) return;
    if(second.length == 1) changeSecond = "0$changeSecond";
    _tenthList
        .firstWhere((element) => element.number == _curTimeSecondTenthPlace)
        .isSelect = false;
    _onesList
        .firstWhere((element) => element.number == _curTimeSecondOnesDigit)
        .isSelect = false;
    _curTimeSecondOnesDigit = int.parse(changeSecond[1]);
    _curTimeSecondTenthPlace = int.parse(changeSecond[0]);
    _tenthList
        .firstWhere((element) => element.number == _curTimeSecondTenthPlace)
        .isSelect = true;
    _onesList
        .firstWhere((element) => element.number == _curTimeSecondOnesDigit)
        .isSelect = true;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  List<NumberSelectData> get onesList => _onesList;

  List<NumberSelectData> get tenthList => _tenthList;
}
