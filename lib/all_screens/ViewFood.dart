import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:restaurantfoodwaste/main.dart';

class ViewFood extends StatefulWidget {
  const ViewFood({Key? key}) : super(key: key);

  @override
  _ViewFoodState createState() => _ViewFoodState();
}

class _ViewFoodState extends State<ViewFood> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//  final view_ref = FirebaseDatabase.instance.reference().child("rest").child(_firebaseAuth.currentUser!.uid).child("food");
  bool active = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("View Food"),
      ),
      body: FirebaseAnimatedList(
        query: food_ref,
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
                    "Food NAME: ${snapshot.value['foodname']}",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "DESCRIPTION: ${snapshot.value['foodDesc']}",
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text("FOOD STATUS: ${snapshot.value['foodStatus']}"),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FlatButton.icon(
                        color: Colors.teal,
                        onPressed: () {
                          updateDialog(
                              snapshot.value['foodname'],
                              snapshot.value['foodDesc'],
                              snapshot.value['foodStatus'],
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
                        color: Colors.teal,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                'DELETE',
                                style: TextStyle(
                                    color: Colors.teal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              content: Container(
                                height: 40.0,
                                child: Column(
                                  children: [
                                    Text(
                                        "Are you sure want to delete this Food?"),
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
                                        color: Colors.teal),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    food_ref.child(snapshot.key!).remove();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            content: Text(
                                      "Food: ${snapshot.value['foodname']} Delete Successfly",
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
                                        color: Colors.teal),
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

  Future<void> updateDialog(
      String name, String desc, String status, BuildContext context, var key) {
    var nameCont = TextEditingController(text: name);
    var descCont = TextEditingController(text: desc);
    var statusCont = TextEditingController(text: status);

    return showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Text(
                "UPDATE",
                style:
                    TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
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
                      labelText: "Food Name",
                      labelStyle: TextStyle(color: Colors.teal),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.teal,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: descCont,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Description",
                      labelStyle: TextStyle(color: Colors.teal),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.teal,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    controller: statusCont,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Status",
                      labelStyle: TextStyle(color: Colors.teal),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.teal,
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
                          color: Colors.teal, fontWeight: FontWeight.bold),
                    )),
                TextButton(
                    onPressed: () {
                      updateData(
                          nameCont.text, descCont.text, statusCont.text, key);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        "FOOD: ${nameCont.text} Updated Successfuly",
                        style: TextStyle(color: Colors.green, fontSize: 18.0),
                      )));
                    },
                    child: Text(
                      "UPDATE",
                      style: TextStyle(
                          color: Colors.teal, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          );
        });
  }

  void updateData(String name, String desc, String status, var key) {
    Map<String, String> x = {
      "foodname": name,
      "foodDesc": desc,
      "foodStatus": status,
    };
    final view_ref = FirebaseDatabase.instance.reference().child("food");
    view_ref.child(key).update(x);
  }
}
