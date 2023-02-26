import 'package:hive_flutter/adapters.dart';

class WalletDb {
  WalletDb._();
  static final WalletDb instance = WalletDb._();
  Box? box;
  init(String name) async {
    await Hive.initFlutter();
    box = await Hive.openBox("name");
  }

  addMoney(Money value) {
    box?.add(value.toMap());
  }

  useMoney(Money value) {
    box?.add(value.toMap());
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
}

class Money {
  Money(
    this.amount, {
    this.reason,
    this.dateTime,
  });
  final String? reason;
  final double amount;
  final DateTime? dateTime;
  Map<String, dynamic> toMap() {
    return {
      "reason": reason,
      'amount': amount,
      'date_time': dateTime,
    };
  }

  static Money fromMap(Map<String, dynamic> value) {
    return Money(
      value["amount"],
      reason: value["reason"],
      dateTime: value["date_time"],
    );
  }

  @override
  String toString() {
    return "<Amount: {$amount} dateTime: $dateTime reason: '$reason'>";
  }
}
