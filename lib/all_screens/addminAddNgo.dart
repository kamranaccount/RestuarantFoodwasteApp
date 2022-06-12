import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurantfoodwaste/Signup/signUpRest.dart';
import 'package:restaurantfoodwaste/all_screens/adminViewNgo.dart';
import 'package:restaurantfoodwaste/main.dart';
import 'package:restaurantfoodwaste/ourwidgets/progrsbar.dart';

class adminAddNgo extends StatefulWidget {
  const adminAddNgo({Key? key}) : super(key: key);

  @override
  _adminAddNgoState createState() => _adminAddNgoState();
}

class _adminAddNgoState extends State<adminAddNgo> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();
  bool _validate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Add NGO's",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            TextButton(
                onPressed: () => exit(0),
                child: Text(
                  "Logout",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 25.0,
                  ),
                  Image.asset(
                    'images/addngo.png',
                    scale: 1,
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Text(
                    "ADD DETAILS",
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.pink,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  TextField(
                    controller: name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.pink,
                      ),
                      errorText: _validate ? 'Please Enter Name' : null,
                      labelText: 'Enter Name',
                      labelStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pink,
                          width: 2,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.email_outlined,
                        color: Colors.pink,
                      ),
                      labelText: 'Enter Email',
                      labelStyle: TextStyle(color: Colors.grey),
                      errorText: _validate ? 'Please Enter Email' : null,
                      border: OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pink,
                          width: 2,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: phone,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.phone,
                        color: Colors.pink,
                      ),
                      labelText: 'Enter Phone Number',
                      labelStyle: TextStyle(color: Colors.grey),
                      errorText: _validate ? 'Please Enter Phone Number' : null,
                      border: OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pink,
                          width: 2,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: address,
                    keyboardType: TextInputType.streetAddress,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.add_location,
                        color: Colors.pink,
                      ),
                      labelText: 'Enter Address',
                      labelStyle: TextStyle(color: Colors.grey),
                      errorText: _validate ? 'Please Enter Address' : null,
                      border: OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pink,
                          width: 2,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: password,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock,
                        color: Colors.pink,
                      ),
                      labelText: 'Enter Password ******',
                      labelStyle: TextStyle(color: Colors.grey),
                      errorText: _validate ? 'Please Enter Password' : null,
                      border: OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pink,
                          width: 2,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        onPressed: () {
                          clearfield();
                        },
                        color: Colors.pink,
                        child: Text(
                          "RESET",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            name.text.isEmpty
                                ? _validate = true
                                : _validate = false;
                            email.text.isEmpty
                                ? _validate = true
                                : _validate = false;
                            phone.text.isEmpty
                                ? _validate = true
                                : _validate = false;
                            address.text.isEmpty
                                ? _validate = true
                                : _validate = false;
                          });
                          if (name.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                              "Fill All Fields",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 20.0),
                            )));
                          } else if (phone.text.length < 11 ||
                              phone.text.length > 11) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                              "Enter 11-Digits",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 18.0),
                            )));
                          } else if (!email.text.contains('@')) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                              "Email Format is Invalid",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 18.0),
                            )));
                          } else {
                            AdminRegNgo(context);
                          }
                        },
                        color: Colors.pink,
                        child: Text(
                          "SUBMIT",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void clearfield() {
    name.clear();
    phone.clear();
    address.clear();
    email.clear();
    password.clear();
    setState(() {});
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void AdminRegNgo(BuildContext context) async {
    final User = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: email.text, password: password.text)
            .catchError((errMsg) {
      if (errMsg.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Email Already In Use",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18.0),
        )));
        clearfield();
      } else if (errMsg.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Email Format is Invalid",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18.0),
        )));
      } else {
        displayToastMessage("Error: " + errMsg.toString(), context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Error Occured!",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18.0),
        )));
      }
    }))
        .user;

    if (User != null) // user created
    {
      //Save user information into Database

      Map userDataMap = {
        //we use trim because The string without any leading and trailing whitespace.
        "ngoname": name.text.trim(),
        "ngoemail": email.text.trim(),
        "ngophone": phone.text.trim(),
        "ngoaddress": address.text.trim(),
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
                return adminViewNgo();
              }));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "NGO Added Successfuly!",
        style: TextStyle(color: Colors.green, fontSize: 18.0),
      )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "New User account has not been Created.",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18.0),
      )));
    }
  }
}
