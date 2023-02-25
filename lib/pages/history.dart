import 'package:flutter/material.dart';
import 'package:smartwallet/database/database.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    List<Money> moneys = WalletDb.instance.getMoneyList();
    return ListView.builder(
      itemCount: moneys.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("Reason"),
          subtitle: Text(moneys[index].reason ?? ""),
          trailing: Text(moneys[index].amount.toString()),
        );
      },
    );
  }
}
