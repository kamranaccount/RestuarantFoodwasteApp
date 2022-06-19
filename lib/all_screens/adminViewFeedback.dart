import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class adminViewFedBck extends StatefulWidget {
  const adminViewFedBck({Key? key}) : super(key: key);

  @override
  _adminViewFedBckState createState() => _adminViewFedBckState();
}

class _adminViewFedBckState extends State<adminViewFedBck> {
  late DatabaseReference feedbck_ref;

  @override
  void initState() {
    feedbck_ref = FirebaseDatabase.instance.reference().child("feedback");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("View Feedback"),
      ),
      body: FirebaseAnimatedList(
        query: feedbck_ref,
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
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "NGO: ${snapshot.value['ngoname']} Give ${snapshot.value['star']} Stars & Comment ${snapshot.value['comment']} To Restaurant: ${snapshot.value['restname']}",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
              elevation: 15,
              shadowColor: Colors.pink,
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: Colors.pink),
              ),
            ),
          );
        },
      ),
    );
  }
}
