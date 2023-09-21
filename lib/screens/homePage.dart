import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:money_minder/styles.dart';
import 'package:money_minder/utils/transactionModel.dart';
import 'package:money_minder/widgets/addTransaction.dart';
import 'package:money_minder/widgets/ammountCard.dart';
import 'package:money_minder/widgets/transactionCard.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

    final transactionModel = Provider.of<TransactionModel>(context);
    List transactionList = transactionModel.transactionList;    

    void createNewTransaction() {
      showDialog(context: context, builder: (context) {
        return AddTransaction(
          transactionModel: transactionModel, // Pass the model to AddTransaction
          currency: currency,
        );
      });
    }
    // void deleteTransaction(int index) {
    //   setState(() {
        
    //   });
    // }
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
                        AmountCard(currency: currency, title: 'Earning', icon: Icons.arrow_downward_rounded, amount: earningAmount,),
                        AmountCard(currency: currency, title: 'Expense', icon: Icons.arrow_upward_rounded, amount: expenseAmount,),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                child: Container(
                  height: 200, // Adjust the height as needed
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 8, blurRadius: 20, offset: Offset(0, 3),),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) { 
                        final reversedIndex = transactionList.length - 1 - index;
                        return TransactionCard(
                          icon: transactionList[reversedIndex][0],
                          account: transactionList[reversedIndex][1],
                          isExpense: transactionList[reversedIndex][2],
                          amount: transactionList[reversedIndex][3],
                          field: transactionList[reversedIndex][4],
                          currency: transactionList[reversedIndex][5],
                          date: transactionList[reversedIndex][6], 
                          deleteTransaction: (context) =>  transactionModel.removeTransaction(reversedIndex),
                        );
                      },
                      itemCount: transactionList.length,
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
            createNewTransaction();
          }, 
          child: Icon(Icons.add, color: accent,), backgroundColor: secondary,
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
