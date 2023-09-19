import 'package:flutter/material.dart';
import 'package:money_minder/styles.dart';

class AmountCard extends StatelessWidget {
  AmountCard({
    super.key,
    required this.currency, required this.title, required this.icon, required this.amount
  });

  final String currency;
  final String title;
  final IconData icon;
  var amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,  // Define the gradient's start and end points
          end: Alignment.topRight,
          colors: [secondary, Color.fromARGB(255, 88, 88, 88)], // Define the colors for the gradient
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      width: 175,
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: accent,),
              SizedBox(width: 5,),
              Text(title, style: TextStyle(color: primary, fontSize: 20),),
              SizedBox(width: 5,),
            ],
          ),
          Text("${amount} ${currency}", style: TextStyle(color: primary, fontSize: 25, fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}
