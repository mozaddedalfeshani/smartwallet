import 'package:flutter/material.dart';
import 'package:smartwallet/pages/balance_controller.dart';
import 'package:smartwallet/pages/my_app.dart';

void main() async {
  //flutter initialize
  WidgetsFlutterBinding.ensureInitialized();
  await BalanceController.instance.loadBalance();
  runApp(const MyApp());
}
