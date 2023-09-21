import 'package:flutter/material.dart';

class TransactionModel extends ChangeNotifier {
  List<List<dynamic>> _transactionList = [
    // [Icons.car_repair_outlined, "Moneybag", true, "450", "Transport", "bdt", "19/09/23"],
  ];

  List<List<dynamic>> get transactionList => _transactionList;

  void addTransaction(List<dynamic> transaction) {
    _transactionList.add(transaction);
    notifyListeners();
  }
  void removeTransaction(int index ){
    _transactionList.removeAt(index);
    notifyListeners();
  }
}
