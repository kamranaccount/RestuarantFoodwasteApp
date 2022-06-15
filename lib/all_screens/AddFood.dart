import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:restaurantfoodwaste/Signup/signup_screen.dart';
import 'package:restaurantfoodwaste/all_screens/ViewFood.dart';
import 'package:restaurantfoodwaste/main.dart';

class AddFood extends StatefulWidget {
  const AddFood({Key? key}) : super(key: key);

  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  TextEditingController foodname = TextEditingController();
  TextEditingController foodDescp = TextEditingController();
  TextEditingController foodStatus = TextEditingController();
  TextEditingController emailtext = TextEditingController();
  late DatabaseReference food_ref;
  @override
  void initState() {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
     food_ref =
    FirebaseDatabase.instance.reference().child("rest").child(_firebaseAuth.currentUser!.uid).child("food");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Add Food"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "WELCOME",
                    style: TextStyle(
                        fontSize: 28.0,
                        color: Colors.teal[900],
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Save Food & Save Life",
                    style: TextStyle(
                        fontSize: 15.0, color: Colors.teal, letterSpacing: 2.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Image.asset(
                    'images/addfood.png',
                    scale: 2,
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  TextField(
                    controller: foodname,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Food Name',
                      focusedBorder: const OutlineInputBorder(
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
                      suffixIcon: IconButton(
                        onPressed: foodname.clear,
                        icon: Icon(Icons.clear),
                        color: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    controller: foodDescp,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Food Description',
                      focusedBorder: const OutlineInputBorder(
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
                      suffixIcon: IconButton(
                        onPressed: foodname.clear,
                        icon: Icon(Icons.clear),
                        color: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextField(
                    controller: foodStatus,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter Food Status',
                      focusedBorder: const OutlineInputBorder(
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
                      suffixIcon: IconButton(
                        onPressed: foodname.clear,
                        icon: Icon(Icons.clear),
                        color: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (foodname.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          "Enter Food Name",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        )));
                      } else if (foodDescp.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          "Enter Food Description",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        )));
                      } else if (foodStatus.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          "Enter Food Status",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        )));
                      } else {
                        food_ref.push().set({
                          'foodStatus': foodStatus.text,
                          'foodDesc': foodDescp.text,
                          'foodname': foodname.text,
                        }).then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewFood())));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          "Your Food Add Successfully!!",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0),
                        )));
                        foodname.clear();
                        foodDescp.clear();
                        foodStatus.clear();
                      }
                    },
                    color: Colors.teal,
                    textColor: Colors.white,
                    child: Container(
                      height: 55.0,
                      child: Center(
                        child: Text(
                          "Add Food",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                        ),
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(24.0),
                      side: BorderSide(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
