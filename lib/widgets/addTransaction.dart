import 'dart:ui';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:money_minder/styles.dart';
import 'package:money_minder/utils/transactionModel.dart';

class AddTransaction extends StatefulWidget {
  final TransactionModel transactionModel;
  final String currency;
  const AddTransaction(
      {Key? key, required this.currency, required this.transactionModel})
      : super(key: key);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  List<String> _item = [
    "Food",
    "Transport",
    "Education",
    "Shopping",
    "Entertainment",
    "Grocery",
    "Medical",
    "Rental",
    "Bill",
    "Loan",
    "Salary",
    "Bonus",
    "Gift",
    "Prize",
    "Refund",
    "Sell",
  ];
  List<IconData> _icon = [
    Icons.lunch_dining,
    Icons.car_repair_outlined,
    Icons.book_outlined,
    Icons.shopping_bag_outlined,
    Icons.movie_creation_outlined,
    Icons.egg,
    Icons.health_and_safety_outlined,
    Icons.money_rounded,
    Icons.feed_outlined,
    Icons.money,
    Icons.monetization_on,
    Icons.card_membership,
    Icons.shopping_bag_outlined,
    Icons.wallet_giftcard_outlined,
    Icons.get_app,
    Icons.sell_outlined
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
  IconData? selectedIcon;

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
                  widget.transactionModel.addTransaction([
                    selectedIcon,
                    "MoneyBag",
                    isExpense,
                    amountController.text,
                    selectedItem,
                    widget.currency,
                    date,
                  ]);
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
                  child: Text(
                    "ADD",
                    style: TextStyle(
                        color: primary,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                child: Center(
                    child: Text(
                  "Expense",
                  style: TextStyle(
                    fontSize: 25,
                    color: isExpense ? primary : secondary,
                  ),
                )),
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
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Center(
                        child: Text("Earning",
                            style: TextStyle(
                              fontSize: 25,
                              color: isExpense ? secondary : primary,
                            ))))),
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
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            value: selectedItem,
            items: _item
                .map((e) => DropdownMenuItem(
                      child: Container(
                        child: Row(
                          children: [
                            Icon(_icon[_item.indexOf(e)],
                                size: 20), // Add the corresponding icon
                            SizedBox(
                                width:
                                    10), // Add spacing between the icon and text
                            Text("${e}", style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                      value: e,
                    ))
                .toList(),
            selectedItemBuilder: ((BuildContext context) => _item
                .map((e) => Row(
                      children: [
                        Icon(_icon[_item.indexOf(e)],
                            size: 20), // Add the corresponding icon
                        SizedBox(
                            width: 10), // Add spacing between the icon and text
                        Text("${e}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ))
                .toList()),
            onChanged: (value) {
              setState(() {
                selectedItem = value!;
                selectedIcon = _icon[_item.indexOf(value)];
              });
            },
            hint: Text(
              "Type",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            underline: Container(),
            isExpanded: true,
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: Colors.black,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: 315,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
              ),
              offset: const Offset(-20, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all(6),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
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
        onPressed: () async {
          DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2022),
              lastDate: DateTime(2024));
          if (newDate == null) return;
          setState(() {
            date = newDate!;
          });
        },
        child: Text(
          "Date: ${date.day} - ${date.month} - ${date.year}",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: secondary),
        ),
      ),
    );
  }
}

class FrostedGlass extends StatelessWidget {
  const FrostedGlass({
    super.key,
    required this.child,
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
    Key? key,
    required this.amnt,
    required this.amount,
  }) : super(key: key);

  final FocusNode amnt;
  final TextEditingController amount;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      focusNode: amnt,
      controller: amount,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black), // Text color
      decoration: InputDecoration(
        labelText: "Amount",
        labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black), // Label color
        contentPadding: const EdgeInsets.all(15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.black54),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.black54),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      cursorColor: Colors.black, // Cursor color
    );
  }
}