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

  double lifeTimeEntity() {
    double value = 0;
    getMoneyList().forEach((element) {
      if (!element.amount.isNegative) {
        value += element.amount;
      }
    });
    return value;
  }

  double lifeTimeUse() {
    double value = 0;
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

  Money.fromMap(Map<String, dynamic> value)
      : amount = value["amount"],
        reason = value["reason"],
        _dateTime = value["date_time"];
  @override
  String toString() {
    return "<Amount: {$amount} dateTime: $dateTime reason: '$reason'>";
  }
}
