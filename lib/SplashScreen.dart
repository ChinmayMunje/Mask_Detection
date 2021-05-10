import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_detection/HomePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), onLoading);
  }

  onLoading() async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
              child: Container(
                height: 130,
                width: 130,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage('https://www.aligareamedics.com/wp-content/uploads/2020/07/mask1-1000x1333.jpg'),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text('Mask Detection',
            style: GoogleFonts.robotoCondensed(
              fontSize: 30,
            ),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xff01AEBC)),
          ),
        ],
      ),
    );
  }
}