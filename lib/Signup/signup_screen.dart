import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurantfoodwaste/Home_screen.dart';
import 'package:restaurantfoodwaste/all_screens/mainpage.dart';
import 'package:restaurantfoodwaste/all_screens/mainpagerest.dart';
import 'package:restaurantfoodwaste/loginscren/loginScrn.dart';
import 'package:restaurantfoodwaste/main.dart';
import 'package:restaurantfoodwaste/otpscreen/otpverify.dart';
import 'package:restaurantfoodwaste/ourwidgets/progrsbar.dart';

class SignupScreen extends StatelessWidget {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();

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
                "NGO's Signup",
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
                      controller: nameTextEditingController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        labelText: "NGO's Name",
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
                      controller: emailTextEditingController,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (text) {
                        email = text;
                      },
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                        labelText: "NGO's Email",
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
                      controller: phoneNumberTextEditingController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.phone,
                          color: Colors.grey,
                        ),
                        labelText: "NGO's Phone Number",
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
                      controller: passwordTextEditingController,
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
                    SizedBox(height: 1.0),
                    TextField(
                      controller: addressTextEditingController,
                      keyboardType: TextInputType.streetAddress,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.add_location_outlined,
                          color: Colors.grey,
                        ),
                        labelText: "NGO's Address",
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
                          if (nameTextEditingController.text.isEmpty) {
                            //Dialog
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  "Please Enter Name",
                                  style:
                                  TextStyle(color: Colors.red, fontSize: 20.0),
                                )));
                          } else if (nameTextEditingController.text.length <
                              3) {
                            //Dialog
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  "Name Must Be Atleast 3 Characters",
                                  style:
                                  TextStyle(color: Colors.red, fontSize: 20.0),
                                )));
                          } else if (nameTextEditingController.text
                              .contains(new RegExp(r'[0-9]'))) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  "Numbers and Special Characeters Are Not Allowed.",
                                  style:
                                  TextStyle(color: Colors.red, fontSize: 20.0),
                                )));
                          } else if (emailTextEditingController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  "Please Enter Email Address",
                                  style:
                                  TextStyle(color: Colors.red, fontSize: 20.0),
                                )));
                          } else if (!emailTextEditingController.text
                              .contains('@')) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  "Invalid Email Address ",
                                  style:
                                  TextStyle(color: Colors.red, fontSize: 20.0),
                                )));
                          } else if (!emailTextEditingController.text
                              .contains('com')) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  "Email Address Is Not Valid",
                                  style:
                                  TextStyle(color: Colors.red, fontSize: 20.0),
                                )));
                          } else if (phoneNumberTextEditingController
                              .text.isEmpty) {
                            //dialog
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  "Please Enter Phone Number",
                                  style:
                                  TextStyle(color: Colors.red, fontSize: 20.0),
                                )));
                          } else if (phoneNumberTextEditingController
                                      .text.length <
                                  11 ||
                              phoneNumberTextEditingController.text.length >
                                  11) {
                            //dialog
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  "Please Enter 11-digits",
                                  style:
                                  TextStyle(color: Colors.red, fontSize: 20.0),
                                )));
                          } else if (passwordTextEditingController
                              .text.isEmpty) {
                            //dialog
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  "Please Enter Password",
                                  style:
                                  TextStyle(color: Colors.red, fontSize: 20.0),
                                )));
                          } else if (passwordTextEditingController.text.length <
                              6) {
                            //dialog
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  "Password Must Be Atleast 6 Characters",
                                  style:
                                  TextStyle(color: Colors.red, fontSize: 20.0),
                                )));
                          } else if (addressTextEditingController
                              .text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  "Please Enter Address",
                                  style:
                                  TextStyle(color: Colors.red, fontSize: 20.0),
                                )));
                          } else if (addressTextEditingController.text.length <
                              3) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  "Enter Atleast 3 Characters for address",
                                  style:
                                  TextStyle(color: Colors.red, fontSize: 20.0),
                                )));
                          } else {
                            signNewNgo(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  "Registered Ngo",
                                  style:
                                  TextStyle(color: Colors.green, fontSize: 20.0),
                                )));
                           
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
                            return LoginScrn();
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
                ), //Text("Already have an Account? Login here")
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

  void signNewNgo(BuildContext context) async {
    final User = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      if (errMsg.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Email already in use",
              style:
              TextStyle(color: Colors.red, fontSize: 20.0),
            )));
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
                  return SignupScreen();
                }));
      } else if (errMsg.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Email format is invalid",
              style:
              TextStyle(color: Colors.red, fontSize: 20.0),
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
              message: "Registering Please Wait..",
            );
          });
      Map userDataMap = {
        //we use trim because The string without any leading and trailing whitespace.
        "ngoname": nameTextEditingController.text.trim(),
        "ngoemail": emailTextEditingController.text.trim(),
        "ngophone": phoneNumberTextEditingController.text.trim(),
        "ngoaddress": addressTextEditingController.text.trim(),
      };
      ngos_ref.child(User.uid).set(userDataMap);
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
                return otpScreen(
                  passemail: email,
                );
              }));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "New User account has not been Created.",
            style:
            TextStyle(color: Colors.red, fontSize: 20.0),
          )));

    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
