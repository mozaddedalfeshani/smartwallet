import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
//import 'package:shared_preferences/shared_preferences.dart';
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

  final _formKey = GlobalKey<FormState>();
  final TextEditingController wasteController = TextEditingController();
  final TextEditingController reason = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (currentTab == 0 || currentTab == 2)
          ? null
          : AppBar(
              title: const Center(
                child: Text(
                  "H I S T O R Y",
                ),
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
                          height: MediaQuery.of(context).size.height * .34,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            border: Border.all(width: .5, color: Colors.black),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                              colors: [
                                Colors.green.shade100,
                                Colors.white,
                                Colors.lightGreen.shade200,
                              ],
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              StreamBuilder(
                                  stream: WalletDb.instance.snapshot(),
                                  builder: (context, snapshot) {
                                    return Flexible(
                                      child: Text(
                                        doubleFormatter(
                                            WalletDb.instance.totalAmount()),
                                        style: const TextStyle(
                                            fontSize: 60, color: Colors.black),
                                      ),
                                    );
                                  }),

                              StreamBuilder(
                                stream: WalletDb.instance.snapshot(),
                                builder: (context, snapshot) {
                                  return Text(
                                    "\t \t\t\t Assume ${BalanceController.instance.dayLeft()} day left!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.blue.shade900,
                                        fontWeight: FontWeight.w500),
                                  );
                                },
                              ),
                              // Text("Hello"),
                            ],
                          ),
                        ),
                      ),
                      // Center(
                      //   child: Container(
                      //     //width: 280,
                      //     decoration: BoxDecoration(
                      //       border: Border.all(
                      //         color: Theme.of(context).colorScheme.onSurface,
                      //       ),
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //     child: const Padding(
                      //       padding: const EdgeInsets.symmetric(horizontal: 80),
                      //       child: Row(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           //balance show
                      //           //container for design more by Murad

                      //           // StreamBuilder(
                      //           //     stream: WalletDb.instance.snapshot(),
                      //           //     builder: (context, snapshot) {
                      //           //       return Flexible(
                      //           //         child: Text(
                      //           //           doubleFormatter(
                      //           //               WalletDb.instance.totalAmount()),
                      //           //           style: const TextStyle(fontSize: 60),
                      //           //         ),
                      //           //       );
                      //           //     }),
                      //           // // const SizedBox(
                      //           // //   width: 30,
                      //           // // ),
                      //           // //emoji
                      //           // Container(
                      //           //   height: 50,
                      //           //   decoration: BoxDecoration(
                      //           //     //color: Colors.white,
                      //           //     borderRadius: BorderRadius.circular(25),
                      //           //   ),
                      //           //   child: AnimatedBuilder(
                      //           //       //stream: null,
                      //           //       animation: BalanceController.instance,
                      //           //       builder: (context, snapshot) {
                      //           //         return Image.asset(
                      //           //           emojiResponse(),
                      //           //         );
                      //           //       }),
                      //           // ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      // StreamBuilder(
                      //   stream: WalletDb.instance.snapshot(),
                      //   builder: (context, snapshot) {
                      //     return Text(
                      //       "Assume ${BalanceController.instance.dayLeft()} day left!",
                      //       textAlign: TextAlign.center,
                      //     );
                      //   },
                      // ),
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
                                textAlign: TextAlign.center,
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
                                textAlign: TextAlign.center,
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
        // FloatingActionButton.extended(
        //   onPressed: () async {
        //     final SharedPreferences pref =
        //         await SharedPreferences.getInstance();
        //     double lifeTimeUse = await WalletDb.instance.lifeTimeUse();
        //     double lifeTimeEntry = await WalletDb.instance.lifeTimeEntity();
        //     WalletDb.instance.resetDb();
        //     pref.setDouble("life_time_use", lifeTimeUse);
        //     pref.setDouble("life_time_entry", lifeTimeEntry);
        //   },
        //   icon: const Icon(CupertinoIcons.arrow_2_circlepath),
        //   label: const Text("Reset"),
        // ),
        const Text(""),
        // FloatingActionButton.extended(
        //   onPressed: () {},
        //   icon: const Icon(Icons.contact_support_outlined),
        //   label: const Text("Contact"),
        // ),
        FloatingActionButton.extended(
          onPressed: () => WalletDb.instance
              .exportHistoryToPdf(ScaffoldMessenger.of(context), context),
          icon: const Icon(CupertinoIcons.arrow_2_circlepath),
          label: const Text("To pdf"),
        )
      ].elementAtOrNull(currentTab),
    );
  }
}
