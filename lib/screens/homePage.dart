import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:money_minder/styles.dart';
import 'package:money_minder/widgets/ammountCard.dart';
import 'package:money_minder/widgets/transactionCard.dart';
class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve profile data from the Hive box
    final myProfile = Hive.box("profile");
    var profileData = myProfile.get("profile_key");

    String userName = profileData["name"] ?? "";
    String currency = profileData["currency"] ?? "";

    //TODO: collect this information from the database
    String earningAmount = '3000';
    String expenseAmount = '1250';

    // Check if profileData is not null and is of the expected type
    if (profileData != null) {
      return Scaffold(
        backgroundColor: primary,
        body: SafeArea(
          child: Column(
            children: [
              //top portion : summary of the earings and expenses
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15,),
                    Text(
                      "Hello",
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      "${userName}",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AmountCard(currency: currency, title: 'Earning', icon: Icons.arrow_upward_rounded, amount: earningAmount,),
                        AmountCard(currency: currency, title: 'Expense', icon: Icons.arrow_downward_rounded, amount: expenseAmount,),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 8,blurRadius: 20, offset: Offset(0, 3),),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TransactionCard(icon: Icons.car_repair_outlined, account: "Moneybag", isExpense: true, amount: "450", field: "Transport", currency: currency,),
                          TransactionCard(icon: MdiIcons.foodForkDrink, account: "Bkash", isExpense: true, amount: "600", field: "Food & Drink", currency: currency),
                          TransactionCard(icon: Icons.attach_money_rounded, account: "Savings", isExpense: false, amount: "5000", field: "Salary",currency: currency),
                        ],
                      ),
                    ),
                  ),
                ),

              )
            ],
          ),
        ),
      );
    } else {
      // Handle the case where profile data is not found or has unexpected types
      return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body: Center(
          child: Text("Profile data not found or has unexpected types."),
        ),
      );
    }
  }
}
