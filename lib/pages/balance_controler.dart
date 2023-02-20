import 'package:flutter/material.dart';

class BalanceControler extends ChangeNotifier {
  BalanceControler._();
  static final BalanceControler instance = BalanceControler._();
  int _balance = 0;
  int get balance => _balance;
  depostit(int value) {
    _balance = _balance + value;
    notifyListeners();
  }

  waste(int value) {
    if ((_balance - value) >= 0) {
      _balance = _balance - value;
      notifyListeners();
    }
  }
}
