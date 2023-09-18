import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Credentials extends StatefulWidget {
  const Credentials({Key? key}) : super(key: key);

  @override
  _CredentialsState createState() => _CredentialsState();
}

class _CredentialsState extends State<Credentials> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _currency = TextEditingController();

  final _profile = Hive.box("profile");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image(image: AssetImage('assets/money2.png'), height: 250,),
              Text('Create Profile', style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),),
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
                onTap: () async {
                  final newProfile = {
                    "name": _name.text,
                    "email": _email.text,
                    "currency": _currency.text,
                  };

                  await _profile.put("profile_key", newProfile);

                  Navigator.of(context).pushReplacementNamed('/home');
                },
                child: Container(
                  margin: EdgeInsets.all(30),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(child: Text("GET STARTED", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 25),)),
                ),
              ),
            ],
          ),
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
      style: TextStyle(fontSize: 22),
    );
  }
}
