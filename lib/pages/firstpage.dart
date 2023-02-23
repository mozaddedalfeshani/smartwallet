import 'package:flutter/material.dart';
import 'package:smartwallet/pages/balance_controler.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController balancecontroler = TextEditingController();
  final TextEditingController daycontroler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: 150),
                      child: Image.asset(
                        "assets/walleticon.png",
                        //height: 300,
                      ),
                    ),
                  ),
                ),
                Text(
                  "Your Daily Wallet !",
                  style: GoogleFonts.lato(),
                ),
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: 400,
                      decoration: BoxDecoration(
                        color: Colors.white60,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(),
                      ),
                      child: Form(
                        key: _formkey,
                        child: Column(children: [
                          ///adding balance tff
                          ///controler work
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: TextFormField(
                              controller: balancecontroler,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(34),
                                  ),
                                ),
                                hintText: "balance",
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
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: TextFormField(
                              controller: daycontroler,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(34),
                                  ),
                                ),
                                hintText: "money/day",
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
                          SizedBox(
                            height: 10,
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      BalanceControler.instance.depostit(
                        //string to int
                        //for int.parse
                        int.parse(balancecontroler.text),
                      );
                      BalanceControler.instance.setperday(
                        int.parse(daycontroler.text),
                      );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => HomePage()),
                      // );
                    }
                  },
                  child: Image.asset(
                    "assets/start.png",
                    height: 30,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
