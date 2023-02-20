import 'package:flutter/material.dart';
import 'package:smartwallet/pages/balance_controler.dart';
import 'package:smartwallet/pages/myapp.dart';

void main() async {
  //flutter initialize
  WidgetsFlutterBinding.ensureInitialized();
  await BalanceControler.instance.loadbalance();
  runApp(const MyApp());
}
