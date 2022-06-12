import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurantfoodwaste/Signup/signup_screen.dart';
import 'package:restaurantfoodwaste/loginscren/loginScreenRest.dart';

class ForgetPasswordRest extends StatelessWidget {
  TextEditingController restemailTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 35.0,
              ),
              Image(
                image: AssetImage("images/resetpasspic.png"),
                width: 250.0,
                height: 250.0,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Restaurants Forget Password ",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 40.0,
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: restemailTextEditingController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.email, color: Colors.grey),
                          labelText: "Restaurant Email",
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal,
                              width: 2,
                            ),
                          ),
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          ),
                        ),
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 100.0,
                      ),
                      RaisedButton(
                          color: Colors.teal,
                          textColor: Colors.white,
                          child: Container(
                            height: 50.0,
                            child: Center(
                              child: Text(
                                "Reset Password",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(24.0),
                            side: BorderSide(color: Colors.white),
                          ),
                          onPressed: () {
                            if (restemailTextEditingController.text.isEmpty) {
                              displayToastMessage(
                                  "Please Enter Email Address", context);
                            } else if (!restemailTextEditingController.text
                                .contains('@')) {
                              displayToastMessage(
                                  "Email Address is not Valid", context);
                            } else {
                              resetPassword(context);
                            }
                          }),
                      SizedBox(
                        height: 10.0,
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration: Duration(seconds: 2),
                                  transitionsBuilder: (context, animation,
                                      animationTime, child) {
                                    animation = CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.fastLinearToSlowEaseIn);
                                    return ScaleTransition(
                                      scale: animation,
                                      alignment: Alignment.center,
                                      child: child,
                                    );
                                  },
                                  pageBuilder:
                                      (context, animation, animationTime) {
                                    return LoginScreenRest();
                                  }));
                        },
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.grey),
                            children: [
                              TextSpan(text: 'Click Mistake?'),
                              TextSpan(
                                text: ' Sign in Now',
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: restemailTextEditingController.text);
      Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(seconds: 1),
              transitionsBuilder: (context, animation, animationTime, child) {
                animation = CurvedAnimation(
                    parent: animation, curve: Curves.fastLinearToSlowEaseIn);
                return ScaleTransition(
                  scale: animation,
                  alignment: Alignment.center,
                  child: child,
                );
              },
              pageBuilder: (context, animation, animationTime) {
                return LoginScreenRest();
              }));

      displayToastMessage("Reset password email has been sent!", context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        displayToastMessage('User is not Exist', context);
      } else if (e.code == 'invalid-email') {
        displayToastMessage('Email Format is Invalid', context);
      }
    }
  }
}
