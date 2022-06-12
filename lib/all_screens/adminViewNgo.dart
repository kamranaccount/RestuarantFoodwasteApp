import 'dart:ffi';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class adminViewNgo extends StatefulWidget {
  const adminViewNgo({Key? key}) : super(key: key);

  @override
  _adminViewNgoState createState() => _adminViewNgoState();
}

class _adminViewNgoState extends State<adminViewNgo> {
  @override
  Widget build(BuildContext context) {
    final refngo = FirebaseDatabase.instance.reference().child('ngos');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "VIEW NGO's",
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
        query: refngo,
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
                    "NAME: ${snapshot.value['ngoname']}",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.pink,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Email: ${snapshot.value['ngoemail']}",
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("Phone: ${snapshot.value['ngophone']}"),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("Address: ${snapshot.value['ngoaddress']}"),
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
                              snapshot.value['ngoname'],
                              snapshot.value['ngoemail'],
                              snapshot.value['ngophone'],
                              snapshot.value['ngoaddress'],
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
                                        "Are you sure want to delete this NGO?"),
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
                                    refngo.child(snapshot.key!).remove();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            content: Text(
                                      "Ngo: ${snapshot.value['ngoname']} Delete Successfly",
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
                        "NGO: ${nameCont.text} Updated Successfuly",
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
      "ngoname": name,
      "ngoemail": email,
      "ngophone": phone,
      "ngoaddress": address,
    };
    final refngo = FirebaseDatabase.instance.reference().child('ngos');
    refngo.child(key).update(x);
  }
}
