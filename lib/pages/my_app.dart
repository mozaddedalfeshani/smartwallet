import 'package:flutter/material.dart';
import 'package:smartwallet/database/database.dart';
import 'package:smartwallet/pages/first_page.dart';
import 'package:smartwallet/pages/homepage.dart';
import 'package:smartwallet/setting/setting_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: WalletDb.instance.snapshot(),
        builder: (context, snapshot) {
          return AnimatedBuilder(
              animation: SettingsController.instance,
              builder: (context, snapshot) {
                return MaterialApp(
                  debugShowCheckedModeBanner: true,
                  themeMode: SettingsController.instance.themeMode,
                  theme: ThemeData(
                    brightness: Brightness.light,
                    useMaterial3: true,
                    colorSchemeSeed: Colors.green,
                  ),
                  darkTheme: ThemeData(
                    brightness: Brightness.dark,
                    useMaterial3: true,
                    colorSchemeSeed: Colors.green,
                  ),
                  home: (WalletDb.instance.totalAmount() == 0)
                      ? const FirstPage()
                      : const HomePage(),
                );
              });
        });
  }
}
