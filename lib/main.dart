import 'package:flutter/material.dart';
import 'screens/HomePage.dart';
import 'screens/CreateBlog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //title: 'Flutter New Application',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}
