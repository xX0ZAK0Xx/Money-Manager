import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_minder/screens/account/login.dart';
import 'package:money_minder/screens/account/signup.dart';
import 'package:money_minder/screens/bottomNavigation.dart';
import 'package:money_minder/screens/starterPage.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: GoogleFonts.mulish().fontFamily,
      ),
      initialRoute: '/starterPage',
      routes: {
        '/starterPage' : (context) => StarterPage(isLoggedIn: true,),
        '/bottombar' : (context) => BottomBar(),
        '/login' : (context) => Login(),
        '/signup' :(context) => SignUp(),
      },
    );
  }
}
