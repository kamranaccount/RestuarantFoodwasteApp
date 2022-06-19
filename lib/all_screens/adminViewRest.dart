import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class adminViewRest extends StatefulWidget {
  const adminViewRest({Key? key}) : super(key: key);

  @override
  _adminViewRestState createState() => _adminViewRestState();
}

class _adminViewRestState extends State<adminViewRest> {
  @override
  Widget build(BuildContext context) {
    final refrest = FirebaseDatabase.instance.reference().child('rest');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "VIEW RESTAURANTS",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            TextButton(
                onPressed: () => exit(0),
                child: Text(
                  "Logout",
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ))
          ],
        ),
      ),
      body: FirebaseAnimatedList(
        query: refrest,
        itemBuilder: (context, snapshot, animation, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "NAME: ${snapshot.value['restname']}",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.pink,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Email: ${snapshot.value['restemail']}",
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("Phone: ${snapshot.value['restphone']}"),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("Address: ${snapshot.value['restaddress']}"),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton.icon(
                        color: Colors.pink,
                        onPressed: () {
                          updateDialog(
                              snapshot.value['restname'],
                              snapshot.value['restemail'],
                              snapshot.value['restphone'],
                              snapshot.value['restaddress'],
                              context,
                              snapshot.key);
                        },
                        label: Text(
                          'EDIT',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                      FlatButton.icon(
                        color: Colors.pink,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                'DELETE',
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              content: Container(
                                height: 40.0,
                                child: Column(
                                  children: [
                                    Text(
                                        "Are you sure want to delete this Restaurant?"),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.popAndPushNamed(
                                        context, 'current_user_location');
                                  },
                                  child: Text(
                                    'NO',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pink),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    refrest.child(snapshot.key!).remove();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            content: Text(
                                      "Restaurant: ${snapshot.value['restname']} Delete Successfully",
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 20.0),
                                    )));
                                    Navigator.popAndPushNamed(
                                        context, 'current_user_location');
                                  },
                                  child: Text(
                                    'YES',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pink),
                                  ),
                                ),
                              ],
                            ),
                          );
                          //refStud.child(snapshot.key!).remove();
                        },
                        label: Text(
                          'DELETE',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        ),
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
              elevation: 18,
              shadowColor: Colors.pink,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
          );
        },
      ),
    );
  }

  Future<void> updateDialog(String name, String email, String phone,
      String address, BuildContext context, var key) {
    var nameCont = TextEditingController(text: name);
    var emailCont = TextEditingController(text: email);
    var phoneCont = TextEditingController(text: phone);
    var addressCont = TextEditingController(text: address);
    return showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Text(
                "UPDATE",
                style:
                    TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
              ),
              content: Column(
                children: [
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: nameCont,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Name",
                      labelStyle: TextStyle(color: Colors.pink),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pink,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: emailCont,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.pink),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pink,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: phoneCont,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Phone",
                      labelStyle: TextStyle(color: Colors.pink),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pink,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: addressCont,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Address",
                      labelStyle: TextStyle(color: Colors.pink),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.pink,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "CANCEL",
                      style: TextStyle(
                          color: Colors.pink, fontWeight: FontWeight.bold),
                    )),
                TextButton(
                    onPressed: () {
                      updateData(nameCont.text, emailCont.text,
                          addressCont.text, phoneCont.text, key);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        "Restaurant: ${nameCont.text} Updated Successfuly",
                        style: TextStyle(color: Colors.green, fontSize: 18.0),
                      )));
                    },
                    child: Text(
                      "UPDATE",
                      style: TextStyle(
                          color: Colors.pink, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          );
        });
  }

  void updateData(
      String name, String email, String address, String phone, var key) {
    Map<String, String> x = {
      "restname": name,
      "restemail": email,
      "restphone": phone,
      "restaddress": address,
    };
    final refrest = FirebaseDatabase.instance.reference().child('rest');
    refrest.child(key).update(x);
  }
}
