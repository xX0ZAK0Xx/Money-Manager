import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TransactionModel extends ChangeNotifier {
  late Box _transactionBox;
  late Box _profileBox; // Add a reference to the profile box

  TransactionModel() {
    _transactionBox = Hive.box('transactions');
    _profileBox = Hive.box('profile'); // Initialize the profile box
  }

  List<List<dynamic>> get transactionList {
    return _transactionBox.values.toList().cast<List<dynamic>>();
  }

  void addTransaction(List<dynamic> transaction) {
    _transactionBox.add(transaction);

    // Update the earning or expense in the user profile based on the boolean value
    var profileData = _profileBox.get("profile_key");
    if (profileData != null) {
      var prevEarning = profileData["earning"];
      var prevExpense = profileData["expense"];
      var transactionAmount = double.tryParse(transaction[3] ?? '0') ?? 0.0;
      bool isExpense = transaction[2] == true;

      if (isExpense) {
        _profileBox.put("profile_key", {
          ...profileData,
          "expense": prevExpense + transactionAmount,
        });
      } else {
        _profileBox.put("profile_key", {
          ...profileData,
          "earning": prevEarning + transactionAmount,
        });
      }
    }

    notifyListeners();
  }

  void removeTransaction(int index) {
    // Get the transaction being removed
    var removedTransaction = _transactionBox.getAt(index);
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

    // Remove the transaction from the transactions box
    _transactionBox.deleteAt(index);

    notifyListeners();
  }
}
