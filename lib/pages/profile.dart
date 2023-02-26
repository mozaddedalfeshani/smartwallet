import 'package:flutter/material.dart';
import 'package:smartwallet/database/database.dart';
import 'package:smartwallet/pages/balance_controller.dart';

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
      child: Column(children: [
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
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      Center(
                        child: Text(
                          WalletDb.instance.lifeTimeEntity().toString(),
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
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
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      WalletDb.instance.lifeTimeUse().toString(),
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
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
          child: FilledButton(
            onPressed: () {
              WalletDb.instance.resetDb();
            },
            child: const Text("Reset All"),
          ),
        ),
      ]),
    );
  }
}
