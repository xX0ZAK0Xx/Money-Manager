import 'package:flutter/material.dart';
import 'package:money_minder/styles.dart';


class Credentials extends StatefulWidget {
  const Credentials({super.key});

  @override
  State<Credentials> createState() => _CredentialsState();
}

class _CredentialsState extends State<Credentials> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _currency = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Image(image: AssetImage('assets/money2.png'), height: 250,),
            Text('Create Profile', style: TextStyle(color: accent, fontSize: 25, fontWeight: FontWeight.bold),),
            Container(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  InputBox(controller: _name, text: "Enter your Name"),
                  SizedBox(height: 8),
                  InputBox(controller: _email, text: "Enter your email"),
                  SizedBox(height: 8),
                  InputBox(controller: _currency, text: "Currency"),
                ],
              ),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: (){},
              child: Container(
                margin: EdgeInsets.all(30),
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: secondary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(child: Text("GET  STARTED", style: TextStyle(color: accent, fontWeight: FontWeight.w900, fontSize: 25),)),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class InputBox extends StatefulWidget {
  final TextEditingController controller;
  final String text;


  const InputBox({
    Key? key,
    required this.controller,
    required this.text,
  }) : super(key: key);

  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  bool _obscureText = true; // Local state to handle the visibility of the text

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.text,
        border: UnderlineInputBorder(),
        
      ),
      style: TextStyle(fontSize: 22),// Use local state here
    );
  }
}
