import 'package:flutter/material.dart';
import 'package:money_minder/styles.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password1 = TextEditingController();
  TextEditingController _password2 = TextEditingController();
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
            Text('Sign Up', style: TextStyle(color: accent, fontSize: 25, fontWeight: FontWeight.bold),),
            Container(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  InputBox(controller: _email, text: "Enter your Email", isPass: false),
                  SizedBox(height: 8),
                  InputBox(controller: _password1, text: "Enter your password", isPass: true,),
                  SizedBox(height: 8),
                  InputBox(controller: _password2, text: "Confirm password", isPass: true,),
                ],
              ),
            ),
            Text("Or Connect with", style: TextStyle(color: secondary, fontSize: 18, fontWeight: FontWeight.bold),),
            SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.center  ,children: [
              GestureDetector(
                onTap: () {print('google');},
                child: Image(image: AssetImage('assets/google.png'), height: 40,)),
              SizedBox(width: 40,),
              GestureDetector(
                onTap: () {print('facebook');},
                child: Image(image: AssetImage('assets/facebook.png'),height: 45,))
            ],),
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
                child: Center(child: Text("Sign Up", style: TextStyle(color: accent, fontWeight: FontWeight.w900, fontSize: 25),)),
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
  final bool isPass;


  const InputBox({
    Key? key,
    required this.controller,
    required this.text,
    required this.isPass,
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
        suffixIcon: widget.isPass ? IconButton(
          icon: _obscureText
              ? Icon(Icons.visibility_off, color: accent,)
              : Icon(Icons.visibility, color: accent,),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText; // Toggle local state
            });
          },
        ):null,
      ),
      obscureText: widget.isPass ? _obscureText : false, 
      style: TextStyle(fontSize: 22),// Use local state here
    );
  }
}
