import 'package:animated_typing/animated_typing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:money_minder/screens/account/credentials.dart';
import 'package:money_minder/screens/bottomNavigation.dart';
import 'package:money_minder/screens/homePage.dart';
import 'package:money_minder/styles.dart';

class StarterPage extends StatefulWidget {
  final bool isLoggedIn;
  const StarterPage({super.key, required this.isLoggedIn});

  @override
  State<StarterPage> createState() => _StarterPageState();
}

class _StarterPageState extends State<StarterPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> widget.isLoggedIn ? BottomBar() : Credentials())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 20,),
          Column(
            children: [
              Image(image: AssetImage('assets/logo.png'), height: 150,),
              SizedBox(height: 10,),
              AnimatedTyping(
                text: 'Money Minder',
                duration: Duration(
                  seconds: 2,
                ),
                style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,  // Define the gradient's start and end points
                end: Alignment.topCenter,
                colors: [Colors.black, Color.fromARGB(255, 88, 88, 88)], // Define the colors for the gradient
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right:15),
              child: Column(
                children: [
                  SizedBox(height:30),
                  Text('Never miss any track of your Money', style: TextStyle(
                    color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold
                  ), textAlign: TextAlign.center,),
                  SizedBox(height:80),
                  SpinKitWaveSpinner(color: accent, trackColor: Colors.white10, curve: Curves.bounceIn, duration: Duration(seconds: 2),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}