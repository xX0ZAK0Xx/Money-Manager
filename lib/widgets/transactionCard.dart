import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:money_minder/styles.dart';

class TransactionCard extends StatelessWidget {
  TransactionCard({super.key, required this.icon, required this.account, required this.isExpense, required this.amount, required this.field, required this.currency, required this.date});
  final IconData icon;
   String field=" ";
   String account=" ";
  final bool isExpense;
   String amount="";
   String currency="";
   String date="";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,  // Define the gradient's start and end points
          end: Alignment.topRight,
          colors: [secondary, Color.fromARGB(255, 88, 88, 88)], // Define the colors for the gradient
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //------------------Left Part-------------------
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardHeader(icon: icon, text: field, isAccount: false),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: primary),
                    child: Icon(isExpense? MdiIcons.arrowUp: MdiIcons.arrowDown)
                  ),
                  SizedBox(width: 20,),
                  Text("${amount} ", style: TextStyle(color: primary, fontSize: 25),),
                  Text("${currency}", style: TextStyle(color: primary, fontSize: 20),)
                ],
              )
            ],
          ),
          //------------------Right Part-------------------
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardHeader(icon: Icons.account_balance_wallet_outlined, text: account, isAccount: true),
              Text(date, style: TextStyle(color: primary, fontSize: 20),)
            ],
          ),
        ],
      ),

    );
  }
}

class CardHeader extends StatelessWidget {
  const CardHeader({
    super.key,
    required this.icon,
    required this.text , required this.isAccount
  });

  final IconData icon;
  final String text;
  final bool  isAccount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 150,
      decoration: BoxDecoration(
        gradient: !isAccount ?  LinearGradient(
          begin: Alignment.bottomLeft,  // Define the gradient's start and end points
          end: Alignment.topRight,
          colors: [accent, Color.fromARGB(255, 172, 255, 167)], // Define the colors for the gradient
        ): LinearGradient(
          begin: Alignment.bottomLeft,  // Define the gradient's start and end points
          end: Alignment.topRight,
          colors: [Color.fromARGB(255, 75, 93, 135), Color.fromARGB(255, 131, 137, 199)], // Define the colors for the gradient
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Icon(icon , color: isAccount? primary : secondary), Text(text, style: TextStyle(fontWeight: FontWeight.w700, color: isAccount? primary : secondary),)],
        ),
      ),
    );
  }
}