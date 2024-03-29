// ignore_for_file: file_names, avoid_print

import 'package:d/product/service/database_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DiyetListModel extends ChangeNotifier {
  List<Map<String, dynamic>> diyetList = [];
  List<String> keyList = ['0', '0', '0'];
  List<String> valueList = ['0', '0', '0'];
  List<String> keyList2 = ['0', '0', '0'];
  List<String> valueList2 = ['0', '0', '0'];
  String ogun = '';
  String secondOgun = '';
  String homeViewOgun = '';
  int total = 0;
  String selectedOgunImage = 'breakfast';
  String currentDate = DateFormat('dd').format(DateTime.now());
  String currentDayName = DateFormat('EEEE').format(DateTime.now());

  getCurrentDateInTurkish() {
    if (currentDayName == 'Monday') {
      return 'Pazartesi';
    } else if (currentDayName == 'Tuesday') {
      return 'Salı';
    } else if (currentDayName == 'Wednesday') {
      return 'Çarşamba';
    } else if (currentDayName == 'Thursday') {
      return 'Perşembe';
    } else if (currentDayName == 'Friday') {
      return 'Cuma';
    } else if (currentDayName == 'Saturday') {
      return 'Cumartesi';
    } else if (currentDayName == 'Sunday') {
      return 'Pazar';
    }
  }

  String formattedTime = DateTime.now().toString().substring(11, 16);

  calculateTime() {
    if (formattedTime.compareTo('06:00') >= 0 &&
        formattedTime.compareTo('11:59') < 0) {
      ogun = 'breakfast';
      homeViewOgun = 'breakfast';
    } else if (formattedTime.compareTo('12:00') >= 0 &&
        formattedTime.compareTo('17:59') < 0) {
      ogun = 'lunch';
      homeViewOgun = 'lunch';
    } else if (formattedTime.compareTo('18:00') >= 0 &&
        formattedTime.compareTo('23:00') < 0) {
      ogun = 'dinner';
      homeViewOgun = 'dinner';
    } else {
      ogun = 'snack';
      homeViewOgun = 'snack';
    }

    print('Mevcut Zaman: $formattedTime');
    print('Öğün: $ogun');
  }

  getData() async {
    diyetList =
        await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            .getDiyetList(FirebaseAuth.instance.currentUser!.uid);

    getDayList();
    getDayListByOgun('breakfast');

    print("diyetList: $diyetList");

    print('current day: $currentDate');
    notifyListeners();
  }

  getDayList() {
    calculateTime();
    Map<String, dynamic>? desiredMap;

    for (Map<String, dynamic> map in diyetList) {
      if (map['day'] == currentDate) {
        desiredMap = map;
        break;
      }
    }

    if (desiredMap != null) {
      print('İstenilen map: $desiredMap');
      print('${desiredMap[ogun]}');
      Map<String, dynamic> lunchMap = desiredMap[ogun];

      for (int i = 0; i < lunchMap.length; i++) {
        keyList[i] = lunchMap.keys.toList()[i];
        valueList[i] = lunchMap.values.toList()[i];
      }
    } else {
      print('İstenilen gün değerine sahip map bulunamadi.');
    }
  }

  getDayListByOgun(String ogunByString) {
    calculateTime();
    Map<String, dynamic>? desiredMap;

    for (Map<String, dynamic> map in diyetList) {
      if (map['day'] == currentDate) {
        desiredMap = map;
        break;
      }
    }

    if (desiredMap != null) {
      print('İstenilen map: $desiredMap');
      print('${desiredMap[ogunByString]}');
      Map<String, dynamic> lunchMap = desiredMap[ogunByString];

      total = 0;
      for (int i = 0; i < lunchMap.length; i++) {
        keyList2[i] = lunchMap.keys.toList()[i];
        valueList2[i] = lunchMap.values.toList()[i];
      }
    } else {
      print('İstenilen gün değerine sahip map bulunamadi.');
    }
    if (ogunByString == 'breakfast') {
      selectedOgunImage = 'breakfast';
    }
    if (ogunByString == 'lunch') {
      selectedOgunImage = 'lunch';
    }
    if (ogunByString == 'dinner') {
      selectedOgunImage = 'dinner';
    }
    if (ogunByString == 'snack') {
      selectedOgunImage = 'snack';
    }
  }
}
