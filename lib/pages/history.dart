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
    List<Money> moneys = WalletDb.instance.getMoneyList();
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView.builder(
        itemCount: moneys.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(),
              ),
              child: ListTile(
                title: Text(
                  "Reason: ${moneys[index].reason}",
                  style: GoogleFonts.lato(),
                ),
                subtitle: Text(
                  "Amount: ${moneys[index].amount}\n",
                  style: TextStyle(color: Colors.red.shade400),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
