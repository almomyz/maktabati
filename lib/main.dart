import 'package:flutter/material.dart';
import 'package:maktabati2/Pages_View/Add_pages/Add_Categories.dart';
import 'package:maktabati2/Pages_View/Add_pages/Add_auther.dart';
import 'package:maktabati2/Pages_View/Main_pages/Navigtion_Bar.dart';
import 'package:maktabati2/const/ErrornInternt.dart';
import 'package:maktabati2/introduction_screen/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Pages_View/Details_Pages/Details_book.dart';
import 'Pages_View/Details_Pages/downlod.dart';
import 'Pages_View/auth/login.dart';
bool show = true;
late SharedPreferences sharedPref;
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  show = prefs.getBool('ON_BOARDING') ?? true ;
  sharedPref =await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Maktabati_App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
      // FileDownloader()
      // View_PDF()
     show ? onboarding():sharedPref.getString("id")==null?
      Login() : BottomNavBar(),
     //  //onboarding()
     // Detalis_book()
      // :Login()
//
    );
  }
}

