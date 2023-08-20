import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartwallet/database/database.dart';
import 'package:smartwallet/pages/balance_controller.dart';
import 'package:smartwallet/pages/history.dart';
import 'package:smartwallet/pages/profile.dart';
import 'package:smartwallet/utils/double_formatter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;
  //cpp function
  // String emojiResponse() {
  //   double balance = WalletDb.instance.totalAmount();
  //   int day = BalanceController.instance.perDayNeed;

  //   if ((balance / day) <= 2) {
  //     if (Theme.of(context).brightness == Brightness.dark) {
  //       return "assets/darktheme/saddark.png";
  //     } else {
  //       return "assets/sad.png";
  //     }
  //   } else if ((balance / day) > 2 && (balance / day) < 7) {
  //     if (Theme.of(context).brightness == Brightness.dark) {
  //       return "assets/darktheme/twodaynight.png";
  //     } else {
  //       return "assets/twoDay.png";
  //     }
  //   } else {
  //     if (Theme.of(context).brightness == Brightness.dark) {
  //       return "assets/darktheme/happydark.png";
  //     } else {
  //       return "assets/happy.png";
  //     }
  //   }
  // }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController wasteController = TextEditingController();
  final TextEditingController reason = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (currentTab == 2)
          ? null
          : AppBar(
              title: const Text(
                "A penny saved is a penny earned",
              ),
            ),
      body: [
        SafeArea(
          child: Form(
            key: _formKey,
            child: StreamBuilder(
                stream: WalletDb.instance.snapshot(),
                builder: (context, snapshot) {
                  return ListView(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: Container(
                          //width: 280,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                //balance show
                                StreamBuilder(
                                    stream: WalletDb.instance.snapshot(),
                                    builder: (context, snapshot) {
                                      return Flexible(
                                        child: Text(
                                          doubleFormatter(
                                              WalletDb.instance.totalAmount()),
                                          style: const TextStyle(fontSize: 60),
                                        ),
                                      );
                                    }),
                                // const SizedBox(
                                //   width: 30,
                                // ),
                                // //emoji
                                // Container(
                                //   height: 50,
                                //   decoration: BoxDecoration(
                                //     //color: Colors.white,
                                //     borderRadius: BorderRadius.circular(25),
                                //   ),
                                //   child: AnimatedBuilder(
                                //       //stream: null,
                                //       animation: BalanceController.instance,
                                //       builder: (context, snapshot) {
                                //         return Image.asset(
                                //           emojiResponse(),
                                //         );
                                //       }),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      StreamBuilder(
                        stream: WalletDb.instance.snapshot(),
                        builder: (context, snapshot) {
                          return Text(
                            "Assume ${BalanceController.instance.dayLeft()} day left!",
                            textAlign: TextAlign.center,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: reason,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23),
                                  ),
                                  hintText: "Reason",
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                controller: wasteController,
                                inputFormatters: [
                                  FilteringTextInputFormatter(
                                      RegExp(r"^[0-9]*$"),
                                      allow: true)
                                ],
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(23),
                                  ),
                                  hintText: "Amount",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      //cutting button
                      //
                      //
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //
                          //use money button
                          ElevatedButton(
                            onPressed: () {
                              // clean the waste text field
                              WalletDb.instance.addMoney(
                                Money(
                                  -1 * double.parse(wasteController.text),
                                  reason: reason.text.trim(),
                                ),
                              );
                              //clean the reason text field
                              wasteController.clear();
                              reason.clear();
                            },
                            child: const Text("Use Money"),
                          ),
                          const SizedBox(
                            width: 8,
                          ),

                          //
                          //add money button
                          ElevatedButton(
                            onPressed: () {
                              WalletDb.instance.addMoney(
                                Money(
                                  double.parse(wasteController.text),
                                  reason: reason.text.trim(),
                                ),
                              );
                              // clean the waste text field
                              wasteController.clear();
                              //clean the reason text field
                              reason.clear();
                            },
                            child: const Text("Add Money"),
                          ),
                        ],
                      ),
                      if (WalletDb.instance.getMoneyList().isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  for (int i = 0;
                                      i <=
                                          ((WalletDb.instance
                                                      .getMoneyList()
                                                      .length >=
                                                  3)
                                              ? 2
                                              : WalletDb.instance
                                                      .getMoneyList()
                                                      .length -
                                                  1);
                                      i++) ...[
                                    HistoryListTile(
                                        money: WalletDb.instance
                                            .getMoneyList()
                                            .reversed
                                            .elementAt(i)),
                                  ]
                                ],
                              ),
                            ),
                          ),
                        )
                    ],
                  );
                }),
          ),
        ),
        const HistoryPage(),
        const ProfilePage(),
      ][currentTab],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GNav(
          selectedIndex: currentTab,
          color: Theme.of(context).colorScheme.onSurface,
          activeColor: Theme.of(context).colorScheme.primary,
          onTabChange: (value) {
            setState(() {
              currentTab = value;
            });
          },
          tabs: const [
            GButton(
              icon: CupertinoIcons.home,
              text: " Home",
            ),
            GButton(
              icon: CupertinoIcons.news,
              text: " History",
            ),
            GButton(
              icon: CupertinoIcons.chart_bar,
              text: " More",
            ),
          ],
        ),
      ),
      floatingActionButton: [
        FloatingActionButton.extended(
          onPressed: () async {
            final SharedPreferences pref =
                await SharedPreferences.getInstance();
            double lifeTimeUse = await WalletDb.instance.lifeTimeUse();
            double lifeTimeEntry = await WalletDb.instance.lifeTimeEntity();
            WalletDb.instance.resetDb();
            pref.setDouble("life_time_use", lifeTimeUse);
            pref.setDouble("life_time_entry", lifeTimeEntry);
          },
          icon: const Icon(CupertinoIcons.arrow_2_circlepath),
          label: const Text("Reset"),
        ),
        FloatingActionButton.extended(
          onPressed: () => WalletDb.instance.exportHistoryToPdf(),
          icon: const Icon(CupertinoIcons.arrow_2_circlepath),
          label: const Text("To pdf"),
        )
      ].elementAtOrNull(currentTab),
    );
  }
}
