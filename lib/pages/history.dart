import 'package:flutter/material.dart';
import 'package:smartwallet/database/database.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    List<Money> moneys = WalletDb.instance.getMoneyList().reversed.toList();
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView.builder(
        itemCount: moneys.length,
        itemBuilder: (context, index) {
          return HistoryListTile(money: moneys[index]);
        },
      ),
    );
  }
}

class HistoryListTile extends StatelessWidget {
  const HistoryListTile({
    super.key,
    required this.money,
  });

  final Money money;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            width: 1,
          ),
        ),
        child: ListTile(
          title: Text(
            "Reason: ${money.reason}",
            style: GoogleFonts.lato(),
          ),
          subtitle: RichText(
            text: TextSpan(
              text: "Amount: ",
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: "${money.amount}",
                  style: TextStyle(
                      color: (money.amount >= 0)
                          ? Colors.green
                          : Colors.red.shade400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
