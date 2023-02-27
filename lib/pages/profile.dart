import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartwallet/database/database.dart';
import 'package:smartwallet/pages/balance_controller.dart';
import 'package:smartwallet/setting/setting_controller.dart';
import 'package:smartwallet/utils/double_formatter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String emojiResponse() {
    double balance = WalletDb.instance.totalAmount();
    int day = BalanceController.instance.perDayNeed;

    if ((balance / day) <= 2) {
      return "assets/twoday.gif";
    } else if ((balance / day) > 2 && (balance / day) <= 5) {
      return "assets/lt5d.gif";
    } else if ((balance / day) > 5 && (balance / day) <= 10) {
      return "assets/lt7d.gif";
    } else if ((balance / day) > 10 && (balance / day) <= 20) {
      return "assets/mt10d.gif";
    } else {
      return "assets/mt20d.gif";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                //color: Colors.green,
              ),
              child: StreamBuilder(
                  stream: WalletDb.instance.snapshot(),
                  builder: (context, snapshot) {
                    return Image.asset(emojiResponse());
                  }),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "S U M M A R Y",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          //life time box
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green.shade100,
                  ),
                  height: 150,
                  width: 150,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Added ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black),
                        ),
                        Center(
                          child: FutureBuilder(
                              future: WalletDb.instance.lifeTimeEntity(),
                              builder: (context, snapshot) {
                                return Text(
                                  (snapshot.data != null)
                                      ? doubleFormatter(snapshot.data!)
                                      : "",
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                );
                              }),
                        )
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.red.shade100,
                  ),
                  height: 150,
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Usage ",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      FutureBuilder(
                          future: WalletDb.instance.lifeTimeUse(),
                          builder: (context, snapshot) {
                            return Text(
                              (snapshot.data != null)
                                  ? doubleFormatter(snapshot.data!)
                                  : "",
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FilledButton(
                  onPressed: () async {
                    final SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    WalletDb.instance.resetDb();
                    pref.setDouble("life_time_use", 0);
                    pref.setDouble("life_time_entry", 0);
                  },
                  child: const Text("Reset All"),
                ),
                AnimatedBuilder(
                  animation: SettingsController.instance,
                  builder: (context, snapshot) {
                    return IconButton(
                      onPressed: () {
                        var brightness = Theme.of(context).brightness;
                        SettingsController.instance.setThemeMode(
                            (brightness == Brightness.light)
                                ? ThemeMode.dark
                                : ThemeMode.light);
                      },
                      icon: (Theme.of(context).brightness == Brightness.light)
                          ? const Icon(Icons.dark_mode)
                          : const Icon(Icons.sunny),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
