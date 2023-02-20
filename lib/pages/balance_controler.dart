import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BalanceControler extends ChangeNotifier {
  BalanceControler._();
  static final BalanceControler instance = BalanceControler._();
  int _balance = 0;
  int _perdayneed = 1;

  int get balance => _balance;
  int get perdayneed => _perdayneed;
  depostit(int value) {
    _balance = _balance + value;
    _updatepref(_balance);
    notifyListeners();
  }

  waste(int value) {
    if ((_balance - value.abs()) >= 0) {
      _balance = _balance - value.abs();
      _updatepref(_balance);
      notifyListeners();
    }
  }

  setperday(int value) {
    _perdayneed = value;
    _updateperday(_perdayneed);
    notifyListeners();
  }

  int dayleft() {
    return (_balance / _perdayneed).toInt();
  }

  zero() {
    _balance = 0;
    _updatepref(0);
    notifyListeners();
  }

  _updatepref(int value) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setInt("balancekey", value);
  }

  _updateperday(int value) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setInt("daykey", value);
  }

  

  loadbalance() async {
    var pref = await SharedPreferences.getInstance();
    _balance = pref.getInt("balancekey") ?? 0;

    _perdayneed = pref.getInt("daykey") ?? 1;
  }
}
