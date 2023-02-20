import 'package:flutter/material.dart';
import 'package:smartwallet/pages/balance_controler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String emojiresponse() {
    int balance = BalanceControler.instance.balance;
    if (balance < 100) {
      return "assets/sad.png";
    } else if (balance > 100 && balance < 500) {
      return "assets/twoDay.jpeg";
    } else {
      return "assets/happy.png";
    }
  }

  final _formkey = GlobalKey<FormState>();
  final TextEditingController wastecontroler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "A penny saved is a penny earned",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        shadowColor: Colors.white,
      ),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Center(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.sta,
                  children: [
                    //balance show
                    AnimatedBuilder(
                        //
                        //stream: null,
                        animation: BalanceControler.instance,
                        builder: (context, snapshot) {
                          return Text(
                            BalanceControler.instance.balance.toString(),
                            style: TextStyle(fontSize: 60),
                          );
                        }),
                    //emoji
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: AnimatedBuilder(
                          //stream: null,
                          animation: BalanceControler.instance,
                          builder: (context, snapshot) {
                            return Image.asset(
                              emojiresponse(),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child: TextFormField(
                  controller: wastecontroler,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(23),
                    ),
                    hintText: "Waste Money",
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  BalanceControler.instance
                      .waste(int.parse(wastecontroler.text));
                },
                child: Text("Cut from my Balance"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
