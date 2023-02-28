import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smartwallet/database/database.dart';
import 'package:smartwallet/pages/balance_controller.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController balanceController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "assets/animated/intro2.gif",
                      ),
                    ),
                  ),
                ),
                const Text(
                  "Your Daily Wallet !",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Form(
                      key: _formKey,
                      child: Column(children: [
                        if (Theme.of(context).brightness ==
                            Brightness.dark) ...{
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            child: TextFormField(
                              controller: balanceController,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                ),
                                hintText: "Balance",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Add Balance";
                                }
                                if (!RegExp(r"^\d*$").hasMatch(value)) {
                                  return "It's should be number";
                                }
                                if (value.length >= 6) {
                                  return "0 to 99999 and must be number";
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: TextFormField(
                              controller: dayController,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18),
                                  ),
                                ),
                                hintText: "Money/Day",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please add your daily need";
                                }
                                if (!RegExp(r"^\d*$").hasMatch(value)) {
                                  return "It's should be number";
                                }
                                return null;
                              },
                            ),
                          ),
                        } else if (Theme.of(context).brightness ==
                            Brightness.light)
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 10),
                                  child: TextFormField(
                                    controller: balanceController,
                                    decoration: const InputDecoration(
                                      hintStyle: TextStyle(color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(18),
                                        ),
                                      ),
                                      hintText: "Balance",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please Add Balance";
                                      }
                                      if (!RegExp(r"^\d*$").hasMatch(value)) {
                                        return "It's should be number";
                                      }
                                      if (value.length >= 6) {
                                        return "0 to 99999 and must be number";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                  child: TextFormField(
                                    controller: dayController,
                                    decoration: const InputDecoration(
                                      hintStyle: TextStyle(color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(18),
                                        ),
                                      ),
                                      hintText: "Money/Day",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please add your daily need";
                                      }
                                      if (!RegExp(r"^\d*$").hasMatch(value)) {
                                        return "It's should be number";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ///adding balance tff

                        const SizedBox(
                          height: 10,
                        ),
                      ]),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        WalletDb.instance.addMoney(
                          Money(
                            double.parse(balanceController.text),
                            reason: "Initial Amount",
                          ),
                        );
                        BalanceController.instance.setPerDay(
                          int.parse(dayController.text),
                        );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => HomePage()),
                        // );
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(CupertinoIcons.graph_square_fill),
                        Text(" Analyse"),
                        //Icon(CupertinoIcons.arrow_right),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
