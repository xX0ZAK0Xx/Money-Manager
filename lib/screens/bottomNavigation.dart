import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_minder/screens/accountsPage.dart';
import 'package:money_minder/screens/homePage.dart';
import 'package:money_minder/styles.dart';
import 'package:money_minder/utils/transactionModel.dart';
import 'package:money_minder/widgets/addTransaction.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  int index = 0;// 0 = HomePage, 1 = Account
  final List screens = [HomePage(), Account()];


  @override
  Widget build(BuildContext context) {
  
  final myProfile = Hive.box("profile");
  var profileData = myProfile.get("profile_key");
  String currency = profileData["currency"] ?? "";
  final transactionModel = Provider.of<TransactionModel>(context);

  void createNewTransaction() {
      showDialog(context: context, builder: (context) {
        return AddTransaction(
          transactionModel: transactionModel, // Pass the model to AddTransaction
          currency: currency,
        );
      });
    }

    return Scaffold(
      body: screens[index],
      backgroundColor: primary,
      floatingActionButton: Container(
        margin: EdgeInsets.only(top: 30.0),
        child: ClipOval(
          child: Material(
            color: secondary, // Set the desired background color
            child: InkWell(
              onTap: () {
                createNewTransaction();
              },
              child: SizedBox(
                width: 40, // Adjust the width and height for the desired size
                height: 40,
                child: Icon(
                  Icons.add,
                  color: Colors.white, // Set the desired icon color
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  index = 0;
                }),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(CupertinoIcons.home, color: index==0? secondary : Colors.blueGrey[400], size: 30,),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() {
                  index = 1;
                }),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.account_balance_rounded, color: index==1? secondary : Colors.blueGrey[400], size: 30,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}