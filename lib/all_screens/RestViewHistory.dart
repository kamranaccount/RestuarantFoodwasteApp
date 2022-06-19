import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class RestViewHistory extends StatefulWidget {
  @override
  _RestViewHistoryState createState() => _RestViewHistoryState();
}

class _RestViewHistoryState extends State<RestViewHistory> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late DatabaseReference rest_History;
  @override
  void initState() {
    rest_History = FirebaseDatabase.instance
        .reference()
        .child("rest")
        .child(_firebaseAuth.currentUser!.uid)
        .child("request");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Restaurant View History",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: FirebaseAnimatedList(
        query: rest_History,
        itemBuilder: (context, snapshot, animation, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: Column(
                children: [
                  SizedBox(
                    height: 14.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "This NGO ${snapshot.value['reqngoname']} Sent Request For Food",
                      style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
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
