import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_minder/screens/account/login.dart';
import 'package:money_minder/screens/account/signup.dart';
import 'package:money_minder/screens/bottomNavigation.dart';
import 'package:money_minder/screens/homePage.dart';
import 'package:money_minder/screens/starterPage.dart';
import 'package:money_minder/utils/iconDataAdapter.dart';
import 'package:money_minder/utils/transactionModel.dart';
import 'package:provider/provider.dart';

void main() async {
  GoogleFonts.config.allowRuntimeFetching = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(IconDataAdapter());
  final profileBox = await Hive.openBox("profile");
  await Hive.openBox('transactions');
  final hasProfile = profileBox.isNotEmpty; // Check if a profile exists
  runApp(MyApp(created: hasProfile));
}

class MyApp extends StatelessWidget {
  final  bool created;
  const MyApp({super.key, required this.created});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TransactionModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.white),
          fontFamily: GoogleFonts.mulish().fontFamily,
        ),
        initialRoute: '/starterPage',
        routes: {
          '/starterPage' : (context) => StarterPage(isLoggedIn: created,),
          '/bottombar' : (context) => BottomBar(),
          '/login' : (context) => Login(),
          '/signup' :(context) => SignUp(),
          '/home' :(context) => HomePage(),
        },
      ),
    );
  }
}
