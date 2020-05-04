import 'package:flutter/material.dart';
import 'package:stock_management/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:stock_management/services/firebase_auth.dart';
import 'package:stock_management/screens/Home.dart';
import 'package:stock_management/services/supplementNotifier.dart';

void main() => runApp(
  MultiProvider(providers: [
    ChangeNotifierProvider(
    create: (context)=>AuthNotifier(),
    ),
    ChangeNotifierProvider(
      create: (context)=>SupplementNotifier(),
    )
  ],
   child: MyApp(),
  ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Management',
      theme: ThemeData(
        primarySwatch:  Colors.deepPurple,
        accentColor: Colors.blue,
      ),
      home: Consumer<AuthNotifier>(
        builder: (context,notifier,child){
          return notifier.user !=null?Home():Login();
        }
      )    );
  }
}


