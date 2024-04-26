import 'package:flutter/material.dart';
import 'home.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
        hintColor: Colors.lightBlueAccent,
        primaryColor: Colors.lightBlueAccent,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.lightBlueAccent)),
          hintStyle: TextStyle(color: Colors.lightBlueAccent),
        ),
      ),
    );
  }
}

