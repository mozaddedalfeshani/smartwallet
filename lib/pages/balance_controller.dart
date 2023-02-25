import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartwallet/database/database.dart';

class BalanceController extends ChangeNotifier {
  BalanceController._();
  static final BalanceController instance = BalanceController._();
  int _perDayNeed = 1;
  double get _balance => WalletDb.instance.totalAmount();

  int get perDayNeed => _perDayNeed;

  setPerDay(int value) {
    _perDayNeed = value;
    _updatePerDay(_perDayNeed);
    notifyListeners();
  }

  int dayLeft() {
    return _balance ~/ _perDayNeed;
  }

  _updatePerDay(int value) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setInt("dayKey", value);
  }

  loadBalance() async {
    var pref = await SharedPreferences.getInstance();

    _perDayNeed = pref.getInt("dayKey") ?? 1;
  }
}
