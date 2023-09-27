import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TransactionModel extends ChangeNotifier {
  late Box _transactionBox;
  late Box _profileBox; // Add a reference to the profile box
  List<List<dynamic>> transactions = []; // Add the transactions list

  TransactionModel() {
    _transactionBox = Hive.box('transactions');
    _profileBox = Hive.box('profile'); // Initialize the profile box
    transactions = _transactionBox.values.toList().cast<List<dynamic>>();
  }

  List<List<dynamic>> get transactionList {
    return transactions;
  }

  void addTransaction(List<dynamic> transaction) {
    _transactionBox.add(transaction);
    transactions.add(transaction); // Add the transaction to the list

    // Update the earning or expense in the user profile based on the boolean value
    var profileData = _profileBox.get("profile_key");
    // if (profileData != null) {
    // }
    final DateTime now = DateTime.now();
    final int currentYear = now.year;
    final int currentMonth = now.month;

    final double monthlyExpense = transactions
    .where((transaction) =>
        transaction[2] == true &&
        transaction[6].year == currentYear &&
        transaction[6].month == currentMonth)
    .map((transaction) =>
        double.tryParse(transaction[3].toString()) ?? 0.0)
    .fold(0, (a, b) => a + b);

    final double monthlyEarning = transactions
    .where((transaction) =>
        transaction[2] == false &&
        transaction[6].year == currentYear &&
        transaction[6].month == currentMonth)
    .map((transaction) =>
        double.tryParse(transaction[3].toString()) ?? 0.0)
    .fold(0, (a, b) => a + b);

      bool isExpense = transaction[2] == true;

      var prevEarning = profileData["totalEarning"];
      var prevExpense = profileData["totalExpense"];
      var transactionAmount = double.tryParse(transaction[3] ?? '0') ?? 0.0;

      if (isExpense) {
        _profileBox.put("profile_key", {
          ...profileData,
          "monthlyExpense": monthlyExpense,
          "totalExpense": transactionAmount + prevExpense
        });
      } else {
        _profileBox.put("profile_key", {
          ...profileData,
          "monthlyEarning": monthlyEarning,
          "totalEarning": transactionAmount + prevEarning
        });
      }

    notifyListeners();
  }

  void removeTransaction(int index) {
    // Get the transaction being removed
    var removedTransaction = transactions[index];
    if (removedTransaction != null) {
      // Update the earning or expense in the user profile based on the boolean value
      var profileData = _profileBox.get("profile_key");
      if (profileData != null) {
        var prevEarning = profileData["earning"];
        var prevExpense = profileData["expense"];
        var transactionAmount = double.tryParse(removedTransaction[3] ?? '0') ?? 0.0;
        bool isExpense = removedTransaction[2] == true;

        if (isExpense) {
          _profileBox.put("profile_key", {
            ...profileData,
            "expense": prevExpense - transactionAmount,
          });
        } else {
          _profileBox.put("profile_key", {
            ...profileData,
            "earning": prevEarning - transactionAmount,
          });
        }
      }
    }

    // Remove the transaction from the transactions list
    transactions.removeAt(index);
    // Remove the transaction from the transactions box
    _transactionBox.deleteAt(index);

    notifyListeners();
  }
}
