import 'dart:async';

import 'package:flutter/material.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurantfoodwaste/Signup/signup_screen.dart';
import 'package:restaurantfoodwaste/all_screens/mainpage.dart';
import 'package:restaurantfoodwaste/all_screens/mainpagerest.dart';
import 'package:restaurantfoodwaste/main.dart';
import 'package:restaurantfoodwaste/otpscreen/timer.dart';

class restotpScreen extends StatefulWidget {
  final String passemail;
  const restotpScreen({Key? key, required this.passemail}) : super(key: key);

  @override
  _restotpScreenState createState() => _restotpScreenState();
}

class _restotpScreenState extends State<restotpScreen> {
  final TextEditingController _otpController = TextEditingController();
  late EmailAuth emailAuth =
      new EmailAuth(sessionName: "Restaurant Food Waste App");
  late bool isbuttonActive = true;

  void sendOtp() async {
    var res1 = await emailAuth.sendOtp(recipientMail: widget.passemail);
    if (res1) {
      displayToastMessage("Send OTP Code Successful", context);
    } else {
      displayToastMessage("Couldn't Send OTP Code", context);
    }
  }

  void verifyOTP() {
    var res = emailAuth.validateOtp(
        recipientMail: widget.passemail, userOtp: _otpController.text);
    if (res) {
      displayToastMessage("OTP Verified Successful", context);
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
                return mainpagerest();
              }));
    } else if (start == 0) {
      displayToastMessage("Otp Expire", context);
    } else {
      displayToastMessage("Entered Invalid OTP Code", context);
    }
  }

  int start = 60;
  bool wait = false;
  String button = "Send Code";
  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80.0,
                ),
                Image(
                  image: AssetImage("images/otp_logo.png"),
                  width: 220.0,
                  height: 220.0,
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Restaurant Email Verification",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.0,
                      color: Colors.teal),
                ),
                SizedBox(
                  height: 22.0,
                ),
                Text(
                  'Click on send button to recieve OTP code',
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                ),
                Text(
                  widget.passemail,
                  style: TextStyle(
                      color: Colors.teal, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 1.0,
                      ),
                      TextField(
                        controller: _otpController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          labelText: "Enter 6-digits code",
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
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                FlatButton(
                  onPressed: () {
                    sendOtp();
                  },
                  child: Container(
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: "Click for Send OTP again in ",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: "00:$start",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.teal,
                            fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: " Sec ",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    ])),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                RaisedButton(
                    color: Colors.teal.shade600,
                    textColor: Colors.white,
                    child: Container(
                      height: 50.0,
                      child: Center(
                        child: Text(
                          "Verify Code",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(24.0),
                      side: BorderSide(color: Colors.white),
                    ),
                    onPressed: () {
                      if (start == 0) {
                        setState(() {
                          isbuttonActive = false;
                        });
                        displayToastMessage("Your Code is Expire", context);
                      } else if (_otpController.text.isEmpty) {
                        displayToastMessage("Enter OTP Code", context);
                      } else {
                        verifyOTP();
                      }
                    }),
                SizedBox(
                  height: 18.0,
                ),
                RaisedButton(
                    color: Colors.white,
                    textColor: Colors.white,
                    child: Container(
                      height: 50.0,
                      child: Center(
                        child: Text(
                          button,
                          style: TextStyle(
                              color: Colors.teal, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(24.0),
                      side: BorderSide(color: Colors.teal),
                    ),
                    onPressed: () {
                      sendOtp();
                      OTPNotify();
                      startTimer();
                      displayToastMessage(
                          "Enter Code Within 60 seconds", context);
                      if (start == 0) {
                        setState(() {
                          start = 60;
                        });
                        startTimer();
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
