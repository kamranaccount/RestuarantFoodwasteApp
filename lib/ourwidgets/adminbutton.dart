import 'package:flutter/material.dart';
import 'package:restaurantfoodwaste/Signup/signUpRest.dart';
import 'package:restaurantfoodwaste/all_screens/AdminLogin.dart';

class adminbutton extends StatelessWidget {
  const adminbutton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.0),
      child: RaisedButton(
          elevation: 5,
          color: Colors.white,
          textColor: Colors.teal,
          child: Container(
            height: 50.0,
            child: Center(
              child: Text(
                "BUSINESS ACCOUNT",
                style:
                    TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          shape: new RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey),
          ),
          onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: Duration(seconds: 2),
                    transitionsBuilder:
                        (context, animation, animationTime, child) {
                      animation = CurvedAnimation(
                          parent: animation,
                          curve: Curves.fastLinearToSlowEaseIn);
                      return ScaleTransition(
                        scale: animation,
                        alignment: Alignment.center,
                        child: child,
                      );
                    },
                    pageBuilder: (context, animation, animationTime) {
                      return adminlogin();
                    }));
          }),
    );
  }
}
