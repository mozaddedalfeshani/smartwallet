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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset(
                    "assets/walletIcon.png",
                    height: 300,
                  ),
                ),
              ),
              Form(
                key: _formkey,
                child: Column(children: [
                  Text(
                    "Your Daily Wallet !",
                    style: GoogleFonts.lato(),
                  ),

                  ///adding balance tff
                  ///controler work
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 10),
                    child: TextFormField(
                      controller: balancecontroler,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(34),
                          ),
                        ),
                        hintText: "Add Balace",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Add Balance";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(34))),
                        hintText: "Daily Need!",
                      ),
                    ),
                  ),
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      BalanceControler.instance.depostit(
                          //string to int
                          //for int.parse
                          int.parse(balancecontroler.text));
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => HomePage()),
                      // );
                    }
                  },
                  child: const Icon(Icons.stacked_bar_chart_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
