import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurantfoodwaste/Home_screen.dart';
import 'package:restaurantfoodwaste/all_screens/mainpage.dart';
import 'package:restaurantfoodwaste/all_screens/mainpagerest.dart';
import 'package:restaurantfoodwaste/loginscren/loginScreenRest.dart';
import 'package:restaurantfoodwaste/loginscren/loginScrn.dart';
import 'package:restaurantfoodwaste/main.dart';
import 'package:restaurantfoodwaste/otpscreen/otpverify.dart';
import 'package:restaurantfoodwaste/otpscreen/restotpverify.dart';
import 'package:restaurantfoodwaste/ourwidgets/progrsbar.dart';

class SignupScreenRest extends StatelessWidget {
  TextEditingController restnameTextEditingController = TextEditingController();
  TextEditingController restemailTextEditingController =
      TextEditingController();
  TextEditingController restphoneNumberTextEditingController =
      TextEditingController();
  TextEditingController restpasswordTextEditingController =
      TextEditingController();
  TextEditingController restaddressTextEditingController =
      TextEditingController();

  late String email;

  // late EmailAuth emailAuth =
  // new EmailAuth(sessionName: "Restaurant Food Waste App");
  //
  // void sendOtp() async {
  //   var res = await emailAuth.sendOtp(recipientMail: emailTextEditingController.text);
  //   if (res) {
  //     print("OTP Sent");
  //   } else {
  //     print("Not Send");
  //   }
  // }

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
                image: AssetImage("images/signuppic.png"),
                width: 200.0,
                height: 200.0,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                " Restaurants Signup ",
                style: TextStyle(
                  fontSize: 24.0,
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
                      controller: restnameTextEditingController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        labelText: "Restaurant Name",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.red, fontSize: 15.0),
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
                      controller: restemailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (text) {
                        email = text;
                      },
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                        labelText: "Restaurant Email",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.red, fontSize: 15.0),
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
                    SizedBox(height: 1.0),
                    TextField(
                      controller: restphoneNumberTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.phone,
                          color: Colors.grey,
                        ),
                        labelText: "Phone Number",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.red, fontSize: 15.0),
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
                      controller: restpasswordTextEditingController,
                      obscureText: true,
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
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.red, fontSize: 15.0),
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
                      controller: restaddressTextEditingController,
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.add_location_alt_outlined,
                          color: Colors.grey,
                        ),
                        labelText: "Restaurant Address",
                        labelStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(),
                        errorStyle:
                            TextStyle(color: Colors.red, fontSize: 15.0),
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
                      height: 30.0,
                    ),
                    RaisedButton(
                        color: Colors.teal.shade600,
                        textColor: Colors.white,
                        child: Container(
                          height: 50.0,
                          child: Center(
                            child: Text(
                              "Register",
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
                          if (restnameTextEditingController.text.isEmpty) {
                            //Dialog
                            displayToastMessage("Please Enter Name", context);
                          } else if (restnameTextEditingController.text.length <
                              3) {
                            //Dialog
                            displayToastMessage(
                                "Name Must Be Atleast 3 Characters", context);
                          } else if (restnameTextEditingController.text
                              .contains(new RegExp(r'[0-9]'))) {
                            displayToastMessage(
                                "Numbers and Special Characeters Are Not Allowed.",
                                context);
                          } else if (restemailTextEditingController
                              .text.isEmpty) {
                            displayToastMessage(
                                "Please Enter Email Address", context);
                          } else if (!restemailTextEditingController.text
                              .contains('@')) {
                            displayToastMessage(
                                "Email Address Is Not Valid", context);
                          } else if (restphoneNumberTextEditingController
                              .text.isEmpty) {
                            //dialog
                            displayToastMessage(
                                "Please Enter Phone Number", context);
                          } else if (restphoneNumberTextEditingController
                                      .text.length <
                                  11 ||
                              restphoneNumberTextEditingController.text.length >
                                  11) {
                            //dialog
                            displayToastMessage(
                                "Please Enter 11-digits", context);
                          } else if (restpasswordTextEditingController
                              .text.isEmpty) {
                            //dialog
                            displayToastMessage(
                                "Please Enter Password", context);
                          } else if (restpasswordTextEditingController
                                  .text.length <
                              6) {
                            //dialog
                            displayToastMessage(
                                "Password Must Be Atleast 6 Characters",
                                context);
                          } else if (restaddressTextEditingController
                              .text.isEmpty) {
                            displayToastMessage(
                                "Please Enter Address", context);
                          } else {
                            signNewRest(context);
                            displayToastMessage(
                                "Registered Successfully", context);
                          }
                        }),
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
                            return LoginScreenRest();
                          }));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(text: 'Already have an Acoount '),
                      TextSpan(
                        text: ' Login here',
                        style: TextStyle(
                            color: Colors.teal,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 3,
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
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signNewRest(BuildContext context) async {
    final User = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: restemailTextEditingController.text,
                password: restpasswordTextEditingController.text)
            .catchError((errMsg) {
      if (errMsg.code == 'email-already-in-use') {
        displayToastMessage("Email Already In Use", context);
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: Duration(seconds: 2),
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
                  return SignupScreenRest();
                }));
      } else if (errMsg.code == 'invalid-email') {
        displayToastMessage("Email Format is Invalid", context);
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
              message: "Registering Please Wait..",
            );
          });
      Map userDataMap = {
        //we use trim because The string without any leading and trailing whitespace.
        "restname": restnameTextEditingController.text.trim(),
        "restemail": restemailTextEditingController.text.trim(),
        "restphone": restphoneNumberTextEditingController.text.trim(),
        "restaddress": restaddressTextEditingController.text.trim(),
      };
      rest_ref.child(User.uid).set(userDataMap);
      Navigator.push(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(seconds: 2),
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
                return restotpScreen(
                  passemail: email,
                );
              }));
    } else {
      displayToastMessage("New User account has not been Created.", context);
    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
