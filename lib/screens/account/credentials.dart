import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_minder/styles.dart';

class Credentials extends StatefulWidget {
  const Credentials({Key? key}) : super(key: key);

  @override
  _CredentialsState createState() => _CredentialsState();
}

class _CredentialsState extends State<Credentials> {
  List<String> currencies = [
    "AED", "AFN", "ARS", "AUD", "BAM", "BDT", "BST", "BGN", "BHD", "BIF", "BMD", "BND", "BOB", "BRL", "BYR", "CAD", "CDF", "CHF", "COP", "CZK", "DKK", "DOP", "DZD", "EGP", "EUR", "FJD", "GHS", "GIP", "GMD", "GNF", "GTQ", "GYD", "HKD", "HNL", "HTG", "HUF", "IDR", "ILS", "IMP", "INR", "IQD", "IRR", "ISJ", "ISK", "JEP", "JMD", "JOD", "JPY", "KES", "KGS", "KHR", "KMF", "KID", "KPW", "KRW", "KWD", "LBP", "LKR", "LRD", "LSL", "LYD", "MAD", "MDL", "MGA", "MKD", "MMK", "MNT", "MOP", "MRO", "MUR", "MVR", "MWK", "MXN", "MYR", "MZN", "NAD", "NGN", "NIO", "NOK", "NPR", "NZD", "OMR", "PAB", "PEN", "PGK", "PHP", "PKR", "PLN", "PYG", "QAR", "RON", "RSD", "RUB", "RWF", "SAR", "SBD", "SCR", "SDG", "SEK", "SGD", "SHP", "SLL", "SOS", "SRD", "SSP", "STD", "SYP", "SZL", "THB", "TJR", "TJS", "TMT", "TND", "TOP", "TRY", "TTD", "TVD", "TWD", "TZS", "UAH", "UGX", "USD", "UYU", "UZS", "VED", "VND", "VUV", "WST", "XAF", "XCD", "XOF", "XPF", "YER", "ZAR", "ZMW", "ZWL"
  ];
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _curr = TextEditingController();
  String currency = "BDT";
  final _profile = Hive.box("profile");
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _curr.dispose();
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image(image: AssetImage('assets/money2.png'), height: 250,),
                Text('Create Profile', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
                Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      InputBox(
                        controller: _name, text: "Enter your Name", 
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8),
                      InputBox(controller: _email, text: "Enter your email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 8),
                      currencySelector(),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      // All fields are valid, proceed with submission
                      final newProfile = {
                        "name": _name.text,
                        "email": _email.text,
                        "currency": currency,
                        "monthlyEarning": 0.0,
                        "monthlyExpense": 0.0,
                        "totalEarning": 0.0,
                        "totalExpense": 0.0,
                      };
                      await _profile.put("profile_key", newProfile);
                      Navigator.of(context).pushReplacementNamed('/home');
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(30),
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: secondary,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(child: Text("GET STARTED", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 25),)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
Container currencySelector() {
  return Container(
    padding: EdgeInsets.only(top: 10, bottom: 6),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: secondary,
    ),
    alignment: Alignment.center,
    child: DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        value: currency,
        items: currencies
            .map((e) => DropdownMenuItem(
                  child: Container(
                    child: Text("${e}", style: TextStyle(fontSize: 20)),
                  ),
                  value: e,
                ))
            .toList(),
        selectedItemBuilder: ((BuildContext context) => currencies
            .map((e) => Text("${e}",
                style: TextStyle(
                    fontSize: 25, fontWeight: FontWeight.bold, color: primary),))
            .toList()),
        onChanged: (value) {
          setState(() {
            currency = value!;
          });
        },
        underline: Container(),
        isExpanded: true,
        buttonStyleData: const ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 16),
          height: 40,
          width: 200,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: _curr,
          searchInnerWidgetHeight: 80,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              cursorColor: secondary,
              expands: true,
              textCapitalization: TextCapitalization.characters, // Capitalize input
              enableSuggestions: true,
              maxLines: null,
              controller: _curr,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Search for your currency...',
                hintStyle: const TextStyle(fontSize: 18, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value.toString().contains(searchValue);
          },
        ),
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            _curr.clear();
          }
        },
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_downward_rounded,
          ),
          iconSize: 30,
          iconEnabledColor: Colors.white,
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
  );
}

}

class InputBox extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  final String? Function(String?)? validator; // Add validator function

  const InputBox({
    Key? key,
    required this.controller,
    required this.text,
    this.validator, // Pass the validator function
  }) : super(key: key);

  @override
  _InputBoxState createState() => _InputBoxState();
}


class _InputBoxState extends State<InputBox> {
  bool _obscureText = true; // Local state to handle the visibility of the text

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.text,
        labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        border: UnderlineInputBorder(),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.black54),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      cursorColor: Colors.black,
      validator: widget.validator, // Use the validator function
    );
  }
}
