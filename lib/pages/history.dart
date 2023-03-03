import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartwallet/database/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartwallet/utils/double_formatter.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    List<Money> moneys = WalletDb.instance.getMoneyList().reversed.toList();
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate.fixed(
            [
              Image(
                image: const AssetImage("assets/animated/history.gif")..evict(),
              ),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return HistoryListTile(
                money: moneys[index],
                balance: doubleFormatter(WalletDb.instance
                    .balanceAtIndex(moneys.length - index - 1)),
              );
            },
            childCount: moneys.length,
          ),
        ),
      ],
    );
  }
}

class HistoryListTile extends StatelessWidget {
  const HistoryListTile({super.key, required this.money, this.balance});

  final Money money;
  final String? balance;

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
            "${DateFormat("dd-MM-yyyy").format(money.dateTime)}\n${DateFormat.jm().format(money.dateTime)}\nReason: ${money.reason}",
            style: GoogleFonts.lato(),
          ),
          subtitle: RichText(
            text: TextSpan(
              text: "Amount: ",
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: doubleFormatter(money.amount),
                  style: TextStyle(
                      color: (money.amount >= 0)
                          ? Colors.green
                          : Colors.red.shade400),
                ),
              ],
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(top: 13),
            child: Text(
              balance ?? "",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
