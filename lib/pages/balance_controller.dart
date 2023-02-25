import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BalanceController extends ChangeNotifier {
  BalanceController._();
  static final BalanceController instance = BalanceController._();
  int _balance = 0;
  int _perDayNeed = 1;

  int get balance => _balance;
  int get perDayNeed => _perDayNeed;
  deposit(int value) {
    _balance = _balance + value;
    _updatePref(_balance);
    notifyListeners();
  }

  waste(int value) {
    if ((_balance - value.abs()) >= 0) {
      _balance = _balance - value.abs();
      _updatePref(_balance);
      notifyListeners();
    }
  }

  setPerDay(int value) {
    _perDayNeed = value;
    _updatePerDay(_perDayNeed);
    notifyListeners();
  }

  int dayLeft() {
    return _balance ~/ _perDayNeed;
  }

  zero() {
    _balance = 0;
    _updatePref(0);
    notifyListeners();
  }

  _updatePref(int value) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setInt("balanceKey", value);
  }

  _updatePerDay(int value) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setInt("dayKey", value);
  }

  loadBalance() async {
    var pref = await SharedPreferences.getInstance();
    _balance = pref.getInt("balanceKey") ?? 0;

    _perDayNeed = pref.getInt("dayKey") ?? 1;
  }
}
