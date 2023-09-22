import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TransactionModel extends ChangeNotifier {
  // List<List<dynamic>> _transactionList = [
  //   [Icons.car_repair_outlined, "Moneybag", true, "450", "Transport", "bdt", "19/09/23"],
  // ];
  late Box _transactionBox;

  TransactionModel() {
    _transactionBox = Hive.box('transactions');
  }

  List<List<dynamic>> get transactionList {
    return _transactionBox.values.toList().cast<List<dynamic>>();
  }

  void addTransaction(List<dynamic> transaction) {
    _transactionBox.add(transaction);
    notifyListeners();
  }

  void removeTransaction(int index) {
    _transactionBox.deleteAt(index);
    notifyListeners();
  }
}
