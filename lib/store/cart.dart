


import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {

  //카트
  List<Map<String, dynamic>> _items = [];

//카트 목록 가져오기
  List<Map<String, dynamic>> get items => _items;


  // 카트에 항목 추가
  void addItem(Map<String, dynamic> item) {
    _items.add(item);
    notifyListeners(); // 상태 변경 알림
  }


  // 카트 비우기
  void clearCart() {
    _items.clear();
    notifyListeners();
  }


  // 총 가격 계산
  int get totalPrice {
    int total = 0;
    for (var item in _items) {
      total += int.tryParse(item['price'].toString()) ?? 0;
    }
    return total;
  }

  // 메뉴 이름만 반환
  List get menuNames {
    return _items.map((item) => item['name']).toList();
  }
}




