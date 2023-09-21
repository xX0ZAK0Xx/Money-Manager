import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:money_minder/styles.dart';

class AddTransaction extends StatefulWidget {
  // final TextEditingController amountController;
  // final VoidCallback onAdd;
  final String currency;
  final List transactionList;
  final VoidCallback refreshItems;

  const AddTransaction({super.key, required this.transactionList, required this.currency, required this.refreshItems,});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  List<String> _item = [
    "Food", "Transport", "Education", "Shopping", "Entertainment", "Grocery", "Medical", "Rental", "Bill", "Loan", "Salary", "Bonus", "Gift", "Prize", "Refund", "Sell",
  ];
  bool isExpense = true;

  Color getExpenseColor() {
    return isExpense ? Colors.black : Colors.white;
  }

  Color getEarningColor() {
    return isExpense ? Colors.white : Colors.black;
  }

  void selectExpense() {
    setState(() {
      isExpense = true;
    });
  }

  void selectEarning() {
    setState(() {
      isExpense = false;
    });
  }

  DateTime date = DateTime.now();
  String? selectedItem;

  final TextEditingController amountController = TextEditingController();
  FocusNode amnt = FocusNode();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero, // Set contentPadding to zero
      content: FrostedGlass(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              expenseEarning(),
              selector(),
              AmountBox(amnt: amnt, amount: amountController),
              dateTime(context),
              GestureDetector(
                onTap: () {
                  // final add = AddData(selectedItem!, amount.text, date, isExpense!);
                  // box.add(add);
                  // print("ex:${isExpense}, ${amountController.text}, ${selectedItem}, ${widget.currency}, ${date}");
                  widget.transactionList.add([Icons.car_repair_outlined, "MoneyBag", isExpense, amountController.text, selectedItem, widget.currency, date]);
                  print("addTransaction page: ${widget.transactionList.length}\n" );
                  for (var i = 0; i < widget.transactionList.length; i++) {
                    print("${widget.transactionList[i][0]}, ${widget.transactionList[i][1]}, ${widget.transactionList[i][2]}, ${widget.transactionList[i][3]}, ${widget.transactionList[i][4]}, ${widget.transactionList[i][5]}, ${widget.transactionList[i][6]}\n");
                  }
                  print("\n");
                  widget.refreshItems();
                  amountController.clear();
                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Text("ADD", style: TextStyle(color: primary, fontSize: 25, fontWeight: FontWeight.bold), ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
  Container expenseEarning() {
    return Container(
      decoration: BoxDecoration(
        // color: Color.fromARGB(255, 206, 206, 206),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: isExpense ? null : selectExpense,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: getExpenseColor(),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), bottomLeft: Radius.circular(20), bottomRight: Radius.circular(5), topRight: Radius.circular(5)),
                ),
                child: Center(child: Text("Expense",style: TextStyle( fontSize: 25,
                  color: isExpense ? primary : secondary,
                ),)),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: isExpense ? selectEarning : null,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: getEarningColor(),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5), bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
                ),
                child: Center(child: Text("Earning", style: TextStyle( fontSize: 25,
                  color: isExpense ? secondary : primary,
                )))
              )
            ),
          ),
        ],
      ),
    );
  }

  Container selector() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: Colors.black54, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton<String>(
          value: selectedItem,
          items: _item
              .map((e) => DropdownMenuItem(
                    child: Container(
                      child: Row(children:[
                        // Container(
                        //   margin: EdgeInsets.all(8),
                        //   width: 50,
                        // ),
                        // SizedBox(width: 10,),
                        Text("${e}", style: TextStyle(fontSize: 20),),
                      ]),
                    ),
                    value: e,
                  ))
              .toList(),
          selectedItemBuilder: ((BuildContext context) => _item.map((e) => Row(
            children: [
              // Container(
              //   margin: EdgeInsets.all(10),
              //   width: 50,
              // ),
              // SizedBox(width: 10,),
              Text("${e}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            ],
          )).toList()),
          onChanged: (value) {
            setState(() {
              selectedItem = value!;
            });
          },
          hint: Text(
            "Type",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          dropdownColor: Colors.white,
          underline: Container(),
          isExpanded: true,
        ),
      ),
    );
  }

  Container dateTime(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.black54),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: () async{
          DateTime? newDate = await showDatePicker(context: context, initialDate: date, firstDate: DateTime(2022), lastDate: DateTime(2024));
          if (newDate == null) return;
          setState(() {
            date = newDate!;
          });
        }, child: Text("Date: ${date.day} - ${date.month} - ${date.year}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: secondary),),
      ),
    );
  }
}

class FrostedGlass extends StatelessWidget {
  const FrostedGlass({
    super.key, required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 350,
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.transparent,
        ),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.7),
                    Colors.white.withOpacity(0.5)
                  ],
                ),
              ),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class AmountBox extends StatelessWidget {
  const AmountBox({
    super.key, required this.amnt, required this.amount,
  });

  final FocusNode amnt;
  final TextEditingController amount;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      focusNode: amnt,
      controller: amount,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: "Amount",
        labelStyle:  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        contentPadding: const EdgeInsets.all(15),
        enabledBorder:const OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.black54),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.black54),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        )
      ),
    );
  }
}