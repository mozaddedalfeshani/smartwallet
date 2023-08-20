import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:pdf/widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletDb {
  WalletDb._();
  static final WalletDb instance = WalletDb._();
  Box? box;
  init(String name) async {
    await Hive.initFlutter();
    box = await Hive.openBox("name");
  }

  addMoney(Money value) {
    if (totalAmount() + value.amount < 0) {
      return;
    }
    box?.add(value.toMap());
  }

  // useMoney(Money value) {
  //   box?.add(value.toMap());
  // }

  Future<double> lifeTimeEntity() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    double value = pref.getDouble("life_time_entry") ?? 0;
    getMoneyList().forEach((element) {
      if (!element.amount.isNegative) {
        value += element.amount;
      }
    });
    return value;
  }

  Future<double> lifeTimeUse() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    double value = (-1) * (pref.getDouble("life_time_use")?.abs() ?? 0);
    getMoneyList().forEach((element) {
      if (element.amount.isNegative) {
        value += element.amount;
      }
    });
    return value.abs();
  }

  double balanceAtIndex(int index) {
    double value = 0;
    List<Money> moneys = getMoneyList();
    if (moneys.length <= index) {
      return 0;
    }
    for (int i = 0; i <= index; i++) {
      value += moneys[i].amount;
    }
    return value;
  }

  Money getMoney(int index) {
    return Money.fromMap(box?.getAt(index));
  }

  List<Money> getMoneyList() {
    return box?.values
            .map(
              (e) => Money(
                e["amount"],
                reason: e["reason"],
                dateTime: e["date_time"],
              ),
            )
            .toList() ??
        [];
  }

  resetDb() async {
    await box?.clear();
  }

  double totalAmount() {
    double value = 0;
    getMoneyList().forEach((element) {
      value += element.amount;
    });
    return value;
  }

  Stream snapshot() {
    return box?.watch() ?? const Stream.empty().asBroadcastStream();
  }

  Future exportHistoryToPdf() async {
    List<Money> moneyList = getMoneyList();
    moneyList.sort(
      (a, b) => b.dateTime.compareTo(a.dateTime),
    );
    Document document = Document();
    List<TableRow> rows = [];
    for (Money each in moneyList) {
      rows.add(TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text((each.reason ?? "").isEmpty ? "empty" : each.reason!),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(each.amount.toString()),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(each.dateTime.toString()),
        ),
      ]));
    }
    document.addPage(Page(
      build: (context) {
        return Column(
          children: [
            Center(
              child: Text(
                "History",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text("Reason"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text("Amount"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Text("DateTime"),
                    ),
                  ],
                ),
                ...rows,
              ],
            ),
          ],
        );
      },
    ));
    // permissions
    if (Platform.isAndroid) {
      if (!(await Permission.storage.isGranted)) {
        var status = await Permission.storage.request();
        if (!status.isGranted) {
          print(status);
          return;
        }
      }
    }
    String? path = (Platform.isMacOS || Platform.isWindows)
        ? await FilePicker.platform.saveFile(
            allowedExtensions: ["pdf"],
            fileName: "testing.pdf",
          )
        : await FilePicker.platform.getDirectoryPath();
    if (path == null) {
      return;
    }
    var bytes = await document.save();
    File file = File(path);
    file.writeAsBytesSync(bytes);
  }
}

class Money {
  Money(
    this.amount, {
    this.reason,
    DateTime? dateTime,
  }) : _dateTime = dateTime;
  final String? reason;
  final double amount;
  final DateTime? _dateTime;
  DateTime get dateTime => _dateTime ?? DateTime.now();
  Map<String, dynamic> toMap() {
    return {
      "reason": reason,
      'amount': amount,
      'date_time': dateTime,
    };
  }

  Money.fromMap(Map<dynamic, dynamic> value)
      : amount = value["amount"],
        reason = value["reason"],
        _dateTime = value["date_time"];
  @override
  String toString() {
    return "<Amount: {$amount} dateTime: $dateTime reason: '$reason'>";
  }
}
