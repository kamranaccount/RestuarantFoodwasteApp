import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurantfoodwaste/Home_screen.dart';

class splashscreen extends StatefulWidget {
  @override
  _splashscreenState createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    super.initState();
    this.nextpage();
    this.hideBar();
  }

  nextpage() async {
    await Future.delayed(Duration(seconds: 6), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        ),
        result: (route) => false,
      );
    });
    super.initState();
  }

  hideBar() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 270,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Image.asset(
                    'images/splashpic.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.teal)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
