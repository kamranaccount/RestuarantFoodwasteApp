import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:restaurantfoodwaste/Home_screen.dart';
import 'package:restaurantfoodwaste/Signup/signup_screen.dart';
import 'package:restaurantfoodwaste/all_screens/mainpage.dart';
import 'package:restaurantfoodwaste/loginscren/forgtpasswd.dart';
import 'package:restaurantfoodwaste/otpscreen/otpverify.dart';
import 'package:restaurantfoodwaste/ourwidgets/progrsbar.dart';

import '../main.dart';

class LoginScrn extends StatefulWidget {
  @override
  State<LoginScrn> createState() => _LoginScrnState();
}

class _LoginScrnState extends State<LoginScrn> {
  TextEditingController emailTextEditingController = TextEditingController();

  TextEditingController passwordTextEditingController = TextEditingController();

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exit(0);
      },
      child: Scaffold(
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
                  image: AssetImage(
                    "images/loginlogo.png",
                  ),
                  width: 200.0,
                  height: 200.0,
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "NGO's Login",
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 1.0,
                      ),
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailTextEditingController,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          labelText: "NGO Email",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal,
                              width: 2,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          ),
                        ),
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 1.0,
                      ),
                      TextField(
                        controller: passwordTextEditingController,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal,
                              width: 2,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                          ),
                        ),
                        style: TextStyle(fontSize: 14.0),
                      ),
                      SizedBox(
                        height: 2.0,
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
                                    return ForgetPassword();
                                  }));
                        },
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Forgot Password ",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.teal,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      RaisedButton(
                          color: Colors.teal,
                          textColor: Colors.white,
                          child: Container(
                            height: 50.0,
                            child: Center(
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(24.0),
                            side: BorderSide(color: Colors.white),
                          ),
                          onPressed: () {
                            if (emailTextEditingController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                "Please Enter Email Address",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              )));
                            } else if (!emailTextEditingController.text
                                .contains('@')) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                "Email Address Is Not Valid",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              )));
                            } else if (passwordTextEditingController
                                .text.isEmpty) {
                              //dialog
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                "Please Enter Password",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              )));
                            } else if (passwordTextEditingController
                                    .text.length <
                                6) {
                              //dialog
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                "Password Must Be Atleast 6 Characters",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              )));
                            } else {
                              loginNgo(context);
                            }
                          }),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 30,
                        ),
                        alignment: Alignment.center,
                        child: RichText(
                            text: TextSpan(
                                style: TextStyle(color: Colors.grey),
                                children: [
                              TextSpan(text: 'Dont have an account?'),
                              TextSpan(
                                text: ' Register',
                                style: TextStyle(
                                  color: Colors.teal,
                                  fontSize: 17.0,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                            transitionDuration:
                                                Duration(seconds: 2),
                                            transitionsBuilder: (context,
                                                animation,
                                                animationTime,
                                                child) {
                                              animation = CurvedAnimation(
                                                  parent: animation,
                                                  curve: Curves
                                                      .fastLinearToSlowEaseIn);
                                              return ScaleTransition(
                                                scale: animation,
                                                alignment: Alignment.center,
                                                child: child,
                                              );
                                            },
                                            pageBuilder: (context, animation,
                                                animationTime) {
                                              return SignupScreen();
                                            }));
                                  },
                              ),
                            ])),
                      ),
                    ],
                  ),
                ),
                FlatButton(
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
                              return HomeScreen();
                            }));
                  },
                  child: Text(
                    "Back to Home ",
                    style: TextStyle(
                      color: Colors.teal.shade500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginNgo(BuildContext context) async {
    final User = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      if (errMsg.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Login Details are Incorrect",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18.0),
        )));
      } else if (errMsg.code == "wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Password is Wrong",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18.0),
        )));
      } else if (errMsg.code == "invalid-email") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Email Format is Invalid",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18.0),
        )));
      } else {
        displayToastMessage("Error: " + errMsg.toString(), context);
      }
    }))
        .user;
    if (User != null) // user created
    {
      //Save user information into Database
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ProgressDialog(
              message: "Authenticating Please Wait...",
            );
          });
      ngos_ref.child(User.uid).once().then((DataSnapshot Snap) {
        if (Snap.value != null) {
          Navigator.push(
              context,
              PageRouteBuilder(
                  transitionDuration: Duration(seconds: 1),
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
                    return mainpage();
                  }));

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "You have been login Sucessfully",
            style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 18.0),
          )));
        } else {
          _firebaseAuth.signOut();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            "User doesnt exist, Please create new account",
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18.0),
          )));
        }
      });
    } else {
      displayToastMessage("Error Occured", context);
    }
  }
}
