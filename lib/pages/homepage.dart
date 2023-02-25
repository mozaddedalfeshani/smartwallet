import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smartwallet/database/database.dart';
import 'package:smartwallet/pages/balance_controller.dart';
import 'package:smartwallet/pages/history.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;
  //cpp function
  String emojiResponse() {
    int balance = BalanceController.instance.balance;
    int day = BalanceController.instance.perDayNeed;

    if ((balance / day) <= 2) {
      return "assets/sad.png";
    } else if ((balance / day) > 2 && (balance / day) < 7) {
      return "assets/twoDay.jpeg";
    } else {
      return "assets/happy.png";
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController wasteController = TextEditingController();
  final TextEditingController reason = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BalanceController.instance.zero();
          WalletDb.instance.resetDB();
        },
        child: const Text("Reset!"),
      ),
      appBar: AppBar(
        title: const Text(
          "A penny saved is a penny earned",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        shadowColor: Colors.white,
      ),
      body: [
        SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Container(
                    //width: 280,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //balance show
                          AnimatedBuilder(
                              //
                              //stream: null,
                              animation: BalanceController.instance,
                              builder: (context, snapshot) {
                                return Text(
                                  BalanceController.instance.balance.toString(),
                                  style: const TextStyle(fontSize: 60),
                                );
                              }),
                          const SizedBox(
                            width: 30,
                          ),
                          //emoji
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: AnimatedBuilder(
                                //stream: null,
                                animation: BalanceController.instance,
                                builder: (context, snapshot) {
                                  return Image.asset(
                                    emojiResponse(),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AnimatedBuilder(
                  animation: BalanceController.instance,
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
                        BalanceController.instance
                            .waste(int.parse(wasteController.text));
                        // clean the waste text field
                        wasteController.clear();
                        //clean the reason text field
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
                        BalanceController.instance
                            .deposit(int.parse(wasteController.text));
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
              ],
            ),
          ),
        ),
        const HistoryPage(),
        const Center(
          child: Text("Tab 3"),
        ),
      ][currentTab],
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
                icon: Icons.home,
                text: "Home",
              ),
              GButton(
                icon: Icons.history_toggle_off,
                text: "History",
              ),
              GButton(
                icon: Icons.report,
                text: "Support",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
