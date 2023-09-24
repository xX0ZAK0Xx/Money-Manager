import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:money_minder/styles.dart';

class TransactionCard extends StatelessWidget {
  TransactionCard({super.key, required this.icon, required this.account, required this.isExpense, required this.amount, required this.field, required this.currency, required this.date, required this.deleteTransaction});
  final IconData icon;
   String field=" ";
   String account=" ";
  final bool isExpense;
   String amount="";
   String currency="";
   String date="";
   Function(BuildContext)? deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: StretchMotion(), children: [SlidableAction(
        onPressed: deleteTransaction,
        icon: Icons.delete_outline_outlined,
        backgroundColor: primary,
        autoClose: true,
        borderRadius: BorderRadius.circular(15),
      )]),
      child: Container(
        // margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(15),
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 1, blurRadius: 2, offset: Offset(0, 3),),
          ],
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
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: isExpense? Color.fromARGB(255, 255, 213, 210) : Color.fromARGB(255, 201, 255, 203)),
                      child: Icon(isExpense? MdiIcons.arrowUp: MdiIcons.arrowDown)
                    ),
                    SizedBox(width: 20,),
                    Text("${amount} ", style: TextStyle(color: secondary, fontSize: 25),),
                    Text("${currency}", style: TextStyle(color: secondary, fontSize: 20),)
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
                Text(date, style: TextStyle(color: secondary, fontSize: 20),)
              ],
            ),
          ],
        ),
    
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
      alignment: Alignment.center,
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
          colors: [Color.fromARGB(255, 180, 202, 255), Color.fromARGB(255, 131, 137, 199)], // Define the colors for the gradient
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon , color: const Color.fromARGB(255, 86, 86, 86) ),
            Container(width: 1, height: double.infinity, color: Colors.black,),
            Text(text, style: TextStyle(fontWeight: FontWeight.w700, color: isAccount? primary : secondary),)],
        ),
      ),
    );
  }
}