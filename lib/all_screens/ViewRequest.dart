import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:restaurantfoodwaste/Signup/signUpRest.dart';

class NgoReq extends StatefulWidget {
  final String RestName, RestEmail, RestPhone, RestAddress;
  NgoReq(
      {required this.RestAddress,
      required this.RestEmail,
      required this.RestPhone,
      required this.RestName});
  @override
  _NgoReqState createState() => _NgoReqState();
}

class _NgoReqState extends State<NgoReq> {
  TextEditingController Email = TextEditingController();
  TextEditingController Pass = TextEditingController();
  var getemailngo;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late  DatabaseReference restreqview ;
  @override
  void initState() {
    restreqview =
        FirebaseDatabase.instance.reference().child("rest").child(_firebaseAuth.currentUser!.uid).child("request");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("NGO's Request"),
      ),
      body: FirebaseAnimatedList(
        query: restreqview,
        itemBuilder: (context, snapshot, animation, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: Column(
                children: [
                  SizedBox(
                    height: 14.0,
                  ),
                  Text(
                    "NGO NAME: ${snapshot.value['reqngoname']}",
                    style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "NGO EMAIL: ${snapshot.value['reqngoemail']}",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "NGO ADDRESS: ${snapshot.value['reqngoaddr']}",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "NGO PHONE: ${snapshot.value['reqngophone']}",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  FlatButton(
                      color: Colors.teal,
                      onPressed: () {
                        displayToastMessage(
                            "Enter Gmail Account Details", context);
                        getemailngo = snapshot.value['reqngoemail'];
                        openDialog();
                        restreqview.child(snapshot.key!).remove();
                      },
                      child: Text(
                        "Accept",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
              elevation: 15,
              shadowColor: Colors.tealAccent,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.green),
              ),
            ),
          );
        },
      ),
    );
  }

  sendmail() async {
    final smtpServer = gmail(Email.text, Pass.text);
    final message = Message()
      ..from = Address(Email.text)
      ..recipients.add(getemailngo)
      ..subject = 'Food Status:: 😀 :: ${DateTime.now()}'
      ..text = ' '
      ..html =
          "<h1>Food Request Status</h1>\n<p>Your Request is Accepted By: ${widget.RestName}</p>\n<p>Contact Number is ${widget.RestPhone} and Address is: ${widget.RestAddress}</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Email Sent Successfuly",
        style: TextStyle(
            color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18.0),
      )));
    } on MailerException catch (e) {
      print('Message not sent.');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Email Not Sent",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18.0),
      )));
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Something Went Wrong..",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18.0),
        )));
      }
    }
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Enter Your Gmail Account Details ',
            style: TextStyle(color: Colors.teal),
          ),
          content: Container(
            height: 100.0,
            child: Column(
              children: [
                TextField(
                  controller: Email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Email',
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal,
                        width: 2,
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                TextField(
                  controller: Pass,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Password',
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal,
                        width: 2,
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (Email.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    "Please Enter Email",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  )));
                  displayToastMessage("Please Enter Email", context);
                } else if (!Email.text.contains('@')) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    "Email is Invalid",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  )));
                } else if (Pass.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    "Please Enter Password",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  )));
                  displayToastMessage("Please Enter Password", context);
                } else {
                  sendmail();
                }
              },
              child: Text(
                'Send Email',
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
            ),
          ],
        ),
      );
}
