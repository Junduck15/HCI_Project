import 'package:flutter/material.dart';

class CheckPose with ChangeNotifier {
  List<bool> checkAll = [false, false, false, false, false, false, false, false, false, false];
  int count = 0;
  int sampleIdx = 0;

  void initState() {
    count = 0;
    sampleIdx = 0;
  }

  void changePose() {
    count++;
    print('count: $count');
    if(sampleIdx == 1) {
      sampleIdx = 0;
    } else {
      sampleIdx = 1;
    }
    notifyListeners();
  }

  // void isCheckAll() {
  //   print(checkAll);
  //   // bool allsame = true;
  //   // for(var c in checkAll) {
  //   //   allSame = c;
  //   // }
  //   // if(allSame) {
  //   if(checkAll[2] && checkAll[3]) {
  //     count++;
  //     changePose();
  //     print('count: $count');
  //   }
  //   notifyListeners();
  // }


}