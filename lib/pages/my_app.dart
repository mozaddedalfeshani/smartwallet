import 'package:flutter/material.dart';
import 'package:smartwallet/database/database.dart';
import 'package:smartwallet/pages/first_page.dart';
import 'package:smartwallet/pages/homepage.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: WalletDb.instance.snapshot(),
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: true,
            theme: ThemeData(
              //brightness: Brightness.dark,
              useMaterial3: true,
              colorSchemeSeed: Colors.green,
            ),
            home: (WalletDb.instance.totalAmount() == 0)
                ? const FirstPage()
                : const HomePage(),
          );
        });
  }
}
