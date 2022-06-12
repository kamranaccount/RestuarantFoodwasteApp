import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurantfoodwaste/ourwidgets/adminbutton.dart';
import 'package:restaurantfoodwaste/ourwidgets/easyregistrationprs.dart';

Future<bool?> WarningMsg(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Do you want to exit app?",
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(
                "NO",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
              )),
          TextButton(
              onPressed: () {
                Navigator.pop(context, true);
                exit(0);
              },
              child: Text(
                "YES",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
              )),
        ],
      ),
    );

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("Back Button Pressed!!");
        final PopUpMsg = await WarningMsg(context);
        return PopUpMsg ?? false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              ),
              SizedBox(
                height: 13,
              ),
              Image.asset('images/screen.png'),
              SizedBox(
                height: 22,
              ),
              Text(
                'Welcome',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'Today’s wastage is\ntomorrow’s shortage',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Easyregistrationprs(),
              adminbutton(),
            ],
          ),
        ),
      ),
    );
  }
}
