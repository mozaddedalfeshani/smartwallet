import 'package:flutter/material.dart';
import 'package:smartwallet/database/database.dart';
import 'package:smartwallet/pages/balance_controller.dart';
import 'package:smartwallet/pages/my_app.dart';
import 'package:smartwallet/setting/setting_controller.dart';

void main() async {
  //flutter initialize
  WidgetsFlutterBinding.ensureInitialized();
  await SettingsController.instance.loadSettings();
  await WalletDb.instance.init("wallet");
  await BalanceController.instance.loadBalance();
  runApp(const MyApp());
}
















