import 'package:flutter/material.dart';
import 'package:mask_detection/SplashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      brightness: Brightness.dark,
        primaryColor: Color(0xff01AEBC),
      ),
      home: SplashScreen(),
    );
  }
}

