import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_minder/styles.dart';

class AccountCard extends StatefulWidget {
  AccountCard({Key? key, required this.accountName, required this.balance, required this.accountType});

  final String accountName;
  final int accountType;
  double balance;

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  var accountIcons = [
    Icons.wallet, CupertinoIcons.globe, Icons.credit_card_rounded, Icons.account_balance_rounded
  ];
  @override
  Widget build(BuildContext context) {
    final myProfile = Hive.box("profile");
    var profileData = myProfile.get("profile_key");
    String currency = profileData["currency"] ?? "";

    return Container(
      height: 160, // Increase the height to accommodate the content
      width: double.infinity,
      decoration: BoxDecoration(
        // color: secondary,
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,  // Define the gradient's start and end points
          end: Alignment.topRight,
          colors: [Color.fromARGB(255, 47, 76, 102), Color.fromARGB(255, 72, 137, 221)], // Define the colors for the gradient
        ),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(color: Color.fromARGB(255, 104, 104, 104).withOpacity(0.5), spreadRadius: 2, blurRadius: 5, offset: Offset(0, 1),),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 3,),
          // Account name
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(accountIcons[widget.accountType], color: primary, size: 30,),
              Text("${widget.accountName}", style: TextStyle(color: primary, fontSize: 25),),
              Icon(Icons.edit, color: primary,),
            ],
          ),
          // Balance
          Container(
            height: 70, // Adjust the height to fit the content
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: Colors.white,
            ),
            child: Center(
              child: Text("${widget.balance} ${currency}", style: TextStyle(color: secondary, fontSize: 30, fontWeight: FontWeight.bold),),
            ),
          )
        ],
      ),
    );
  }
}
