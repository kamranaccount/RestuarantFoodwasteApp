import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:restaurantfoodwaste/Signup/signUpRest.dart';

import '../main.dart';

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
  late DatabaseReference restreqview;
  late DatabaseReference food_ref;
  late DatabaseReference request;
  @override
  void initState() {
//<<<<<<< Updated upstream
    restreqview = FirebaseDatabase.instance
        .reference()
        .child("rest")
        .child(_firebaseAuth.currentUser!.uid)
        .child("request");
    food_ref = FirebaseDatabase.instance
        .reference()
        .child("rest")
        .child(_firebaseAuth.currentUser!.uid)
        .child("food");
    request = FirebaseDatabase.instance
        .reference()
        .child("rest")
        .child(_firebaseAuth.currentUser!.uid)
        .child("acceptrequest");
//=======
    restreqview = FirebaseDatabase.instance
        .reference()
        .child("rest")
        .child(_firebaseAuth.currentUser!.uid)
        .child("request");
    food_ref = FirebaseDatabase.instance
        .reference()
        .child("rest")
        .child(_firebaseAuth.currentUser!.uid)
        .child("food");
//>>>>>>> Stashed changes
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
//<<<<<<< Updated upstream
                        // displayToastMessage(
                        //     "Enter Gmail Account Details", context);
                        // getemailngo = snapshot.value['reqngoemail'];
                        //openDialog();
                        request.push().set({
                          'restname': widget.RestName,
                          'restaddress': widget.RestAddress,
                          'restphoneNo': widget.RestPhone,
                          'restemail': widget.RestPhone,
                          'ngoname': snapshot.value['reqngoname'],
                          'ngoemail': snapshot.value['reqngoemail'],
                          'ngoaddress': snapshot.value['reqngoaddr'],
                          'ngophoneno': snapshot.value['reqngophone'],
                        });
                        restreqview.child(snapshot.key!).remove();
// =======
                        // getemailngo = snapshot.value['reqngoemail'];
                        // restreqview.child(snapshot.key!).remove();
// >>>>>>> Stashed changes
                        food_ref.remove();
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
}
