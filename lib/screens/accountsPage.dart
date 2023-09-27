import 'package:flutter/material.dart';
import 'package:money_minder/styles.dart';
import 'package:money_minder/widgets/accountCard.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {

  List<Map<String, dynamic>> accounts = [
    {"name": "Wallet", "balance": 0.0, "type": 0},
    {"name": "Bkash", "balance": 0.0, "type": 1},
    {"name": "Visa", "balance": 0.0, "type": 2},
    {"name": "EXIM", "balance": 0.0, "type": 3},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ACCOUNTS", style: TextStyle(fontWeight: FontWeight.bold, color: secondary),),
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: ListView.separated(
          itemBuilder: (BuildContext context, int index){
            return AccountCard(accountName: accounts[index]["name"], balance: accounts[index]["balance"] as double, accountType: accounts[index]["type"],);
          }, 
          separatorBuilder: (BuildContext context, int index) { 
            return SizedBox(height: 30,);
          }, 
          itemCount: accounts.length
        ),
      ),
    );
  }
}