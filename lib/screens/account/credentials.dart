import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_minder/styles.dart';

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
  final _formKey = GlobalKey<FormState>();

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
                      InputBox(controller: _currency, text: "Currency",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Currency is required';
                          }
                          return null;
                        },
                      ),
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
                        "currency": _currency.text,
                        "earning": 0.0,
                        "expense": 0.0,
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
