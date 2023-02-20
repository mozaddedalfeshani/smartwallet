import 'package:flutter/material.dart';
import 'package:smartwallet/pages/firstpage.dart';
import 'package:smartwallet/pages/secondpage.dart';
import 'package:smartwallet/pages/balance_controler.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        //stream: null,
        animation: BalanceControler.instance,
        builder: (context, snapshot) {
          return MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              colorSchemeSeed: Colors.green,
            ),
            home: (BalanceControler.instance.balance == 0)
                ? const FirstPage()
                : const HomePage(),
          );
        });
  }
}
