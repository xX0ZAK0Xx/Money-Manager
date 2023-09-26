import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_minder/barGraph/graph.dart';
import 'package:money_minder/barGraph/graphMonth.dart';
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
    var earningAmount = profileData["earning"];
    var expenseAmount = profileData["expense"];
    var cashFlow = earningAmount-expenseAmount;

    final transactionModel = Provider.of<TransactionModel>(context);
    List<List<dynamic>> transactionList = transactionModel.transactionList;    

    void createNewTransaction() {
      showDialog(context: context, builder: (context) {
        return AddTransaction(
          transactionModel: transactionModel, // Pass the model to AddTransaction
          currency: currency,
        );
      });
    }

    // Check if profileData is not null and is of the expected type
    if (profileData != null) {
      return Scaffold(
        backgroundColor: primary,
        body: SafeArea(
          child: Column(
            children: [
              //top portion : summary of the earings and expenses
              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 12, left: 12,),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
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
                            SizedBox(height: 10,),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Cashflow", style: TextStyle(color: cashFlow>=0? accent : Colors.red, fontWeight: FontWeight.bold, fontSize: 18),),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text((earningAmount-expenseAmount).toString(), style: TextStyle(color: secondary, fontWeight: FontWeight.bold, fontSize: 35)),
                                Text(" ${currency}")
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("This month", style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AmountCard(currency: currency, title: 'Earning', icon: Icons.arrow_downward_rounded, amount: earningAmount,),
                            AmountCard(currency: currency, title: 'Expense', icon: Icons.arrow_upward_rounded, amount: expenseAmount,),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                  ],
                ),
              ),
              Graph(transactionList: transactionList),
              SizedBox(height: 10,),
              Expanded(
                child: Container(
                  height: 200, // Adjust the height as needed
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withOpacity(0.5), spreadRadius: 8, blurRadius: 20, offset: Offset(0, 3),),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) { 
                        final reversedIndex = transactionList.length - 1 - index;
                        DateTime date = transactionList[reversedIndex][6];
                        return TransactionCard(
                          icon: transactionList[reversedIndex][0] ?? Icons.attach_money_rounded,
                          account: transactionList[reversedIndex][1],
                          isExpense: transactionList[reversedIndex][2],
                          amount: transactionList[reversedIndex][3],
                          field: transactionList[reversedIndex][4] ??" ",
                          currency: transactionList[reversedIndex][5],
                          date: "${date.day}/${date.month}/${date.year}",
                          deleteTransaction: (context) =>  transactionModel.removeTransaction(reversedIndex),
                        );
                      },
                      itemCount: transactionList.length, separatorBuilder: (BuildContext context, int index) { 
                        return SizedBox(height: 10,);
                       },
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

class Graph extends StatefulWidget {
  Graph({
    Key? key,
    required this.transactionList,
  }) : super(key: key);

  final List<List> transactionList;

  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  int selectedGraph = 1; // 0 = weekly, 1 = monthly

  void switchToWeeklyGraph() {
    setState(() {
      selectedGraph = 0;
    });
  }

  void switchToMonthlyGraph() {
    setState(() {
      selectedGraph = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          selectedGraph == 0
              ? WeeklyExpensesChart(transactions: widget.transactionList)
              : MonthlyExpensesChart(transactions: widget.transactionList),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: switchToWeeklyGraph,
                child: Container(
                  height: 25,
                  width: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: selectedGraph == 0 ? secondary : Colors.blueGrey,
                    ),
                    color: Colors.white,
                  ),
                  child: Text("Weekly"),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: switchToMonthlyGraph,
                child: Container(
                  height: 25,
                  width: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: selectedGraph == 1 ? secondary : Colors.blueGrey,
                    ),
                    color: Colors.white,
                  ),
                  child: Text("Monthly"),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
