import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:restaurantfoodwaste/Home_screen.dart';
import 'package:restaurantfoodwaste/Signup/signup_screen.dart';
import 'package:restaurantfoodwaste/all_screens/NgoProfile.dart';
import 'package:restaurantfoodwaste/all_screens/NgoViewHistory.dart';
import 'package:restaurantfoodwaste/all_screens/showFoodDetails.dart';
import 'package:restaurantfoodwaste/all_screens/simpleMap.dart';

import 'NData.dart';

class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  _mainpageState createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  late String getresponse, getcomment;
  var Name, Email, Phone, Address, ReqName, ReqRestName;
  List<Data> datalist = [];
  int activeIndex = 0;
  bool searchState = false;
  TextEditingController controller = TextEditingController();
  String foodStatus = '';

  @override
  void initState() {
    // TODO: implement initState
    controller = TextEditingController();
    super.initState();
    DatabaseReference referenceData =
        FirebaseDatabase.instance.reference().child("rest");
    referenceData.once().then((DataSnapshot dataSnapShot) {
      datalist.clear();
      var keys = dataSnapShot.value.keys;
      var values = dataSnapShot.value;

      for (var key in keys) {
        Data data = new Data(
          values[key]["restname"],
          values[key]["restemail"],
          values[key]["restaddress"],
          values[key]["restphone"],
          values[key]["userId"],
        );
        datalist.add(data);
      }
      setState(() {});
    });
  }

  Future<bool?> WarningMsg(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Do you want to exit app?",
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text(
                  "NO",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                  exit(0);
                },
                child: Text(
                  "YES",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0),
                )),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          print("Back Button Pressed!!");
          final PopUpMsg = await WarningMsg(context);
          return PopUpMsg ?? false;
        },
        child: Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: AppBar(
            backgroundColor: Colors.teal,
            title: !searchState
                ? Text("NGO's Screen")
                : TextField(
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        hintText: 'Search...',
                        hintStyle: TextStyle(color: Colors.white)),
                    onChanged: (text) {
                      SearchNgoMethod(text);
                    },
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
            actions: [
              !searchState
                  ? IconButton(
                      onPressed: () {
                        // Call Method For Searching....
                        setState(() {
                          searchState = !searchState;
                        });
                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        // Call Method For Searching....
                        setState(() {
                          searchState = !searchState;
                        });
                      },
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: Colors.white,
                      ),
                    ),
            ],
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                Container(
                  color: Colors.teal,
                  width: double.infinity,
                  height: 200.0,
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        height: 90.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('images/nlogo.png')),
                        ),
                      ),
                      Text("Welcome NGO",
                          style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.teal.shade900,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic)),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        "Email: $email",
                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.teal,
                  ),
                  title: Text("Profile"),
                  onTap: () {
                    getCurrentUser(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.map,
                    color: Colors.teal,
                  ),
                  title: Text("Simple Map"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MapPage()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.teal,
                  ),
                  title: Text("Setting"),
                  onTap: () {
                    displayToastMessage("Click On Setting", context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.history,
                    color: Colors.teal,
                  ),
                  title: Text("History"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NgoViewHistory()));
                    displayToastMessage("Click On History", context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.teal,
                  ),
                  title: Text("Logout"),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
              ],
            ),
          ),
          body: datalist.length == 0
              ? Center(
                  child: Text(
                  "Data Not Found ...",
                  style: TextStyle(fontSize: 30),
                ))
              : ListView.builder(
                  itemCount: datalist.length,
                  itemBuilder: (_, index) {
                    return CardUI(
                      datalist[index].restname,
                      datalist[index].restemail,
                      datalist[index].restaddress,
                      datalist[index].restphone,
                      datalist[index].userId,
                    );
                  }),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: activeIndex,
            iconSize: 25.0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
                backgroundColor: Colors.teal,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text("Search"),
                backgroundColor: Colors.teal,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                title: Text("Map"),
                backgroundColor: Colors.teal,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text("Profile"),
                backgroundColor: Colors.teal,
              ),
            ],
            onTap: (index) {
              setState(() {
                activeIndex = index;
                if (index == 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const mainpage()));
                } else if (index == 1) {
                  setState(() {
                    searchState = !searchState;
                  });
                } else if (index == 2) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MapPage()));
                } else if (index == 3) {
                  getCurrentUser(context);
                }
              });
            },
          ),
        ),
      );

  Future<void> getCurrentUser(BuildContext context) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    String userId = firebaseUser.uid;
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("ngos").child(userId);
    reference.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        Name = snapshot.value['ngoname'];
        Address = snapshot.value['ngoaddress'];
        Email = snapshot.value['ngoemail'];
        Phone = snapshot.value['ngophone'];
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NgoProfile(
                    getaddress: Address,
                    getemail: Email,
                    getname: Name,
                    getphone: Phone,
                  )),
        );
        print('Ngo Name: ${snapshot.value['ngoname']}');
        print('Ngo Email: ${snapshot.value['ngoemail']}');
        print('Ngo Address: ${snapshot.value['ngoaddress']}');
        print('Ngo Phone: ${snapshot.value['ngophone']}');
      } else {
        print("error");
      }
    });
  }

  Widget CardUI(String restname, String restemail, String restaddress,
      String restphone, String userId) {
    return SingleChildScrollView(
      child: Center(
          child: Container(
        padding: new EdgeInsets.all(8.0),
        child: InkWell(
          child: Card(
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(
                  color: Colors.green,
                )),
            shadowColor: Colors.teal,
            elevation: 15,
            child: Container(
              margin: EdgeInsets.all(1.5),
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    child: Text(
                      "Restaurant: ${restname}",
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    children: [
                      Text(
                        "Email: ${restemail}",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Address: ${restaddress}",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Phone: ${restphone}",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0),
                        child: RaisedButton(
                            color: Colors.teal,
                            textColor: Colors.white,
                            child: Container(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Show Details",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                ),
                              ),
                            ),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              side: BorderSide(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => showFoodDetails(
                                            showName: restname,
                                            showEmail: restemail,
                                            userId: userId,
                                          )));
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5.0, left: 10.0, right: 10.0),
                        child: RaisedButton(
                            color: Colors.teal,
                            textColor: Colors.white,
                            child: Container(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Give Feedback",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ),
                                ),
                              ),
                            ),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              side: BorderSide(color: Colors.white),
                            ),
                            onPressed: () {
                              ReqRestName = restname;
                              ReqCurrentNgo(context);
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  Future<void> ReqCurrentNgo(BuildContext context) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    String userId = firebaseUser.uid;
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("ngos").child(userId);
    reference.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        ReqName = snapshot.value['ngoname'];
        show(ReqName);
      } else {
        print("error");
      }
    });
  }

  void show(String ngoname) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return RatingDialog(
              title: Text(
                "Rate us 😀 ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                    fontSize: 22.0),
              ),
              message: Text(
                "Tap on stars to rate us",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                    fontSize: 20.0),
              ),
              image: Icon(
                Icons.star,
                color: Colors.pinkAccent,
                size: 100,
              ),
              submitButtonText: "SUBMIT",
              submitButtonTextStyle: TextStyle(
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0),
              starColor: Colors.pink,
              onSubmitted: (response) {
                getresponse = response.rating.toString();
                getcomment = response.comment.toString();
                if (response.comment.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    "Please Enter Comment",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  )));
                } else {
                  DatabaseReference feedback =
                      FirebaseDatabase.instance.reference().child("feedback");
                  feedback.push().set({
                    'star': getresponse.toString(),
                    'comment': getcomment.toString(),
                    'ngoname': ngoname.toString(),
                    'restname': ReqRestName.toString(),
                  }).then((value) => null);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    "Successfully Give Feedback To Restaurant: ${ReqRestName}",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  )));
                }
              });
        });
  }

  void SearchNgoMethod(String text) {
    DatabaseReference RestSearchRef =
        FirebaseDatabase.instance.reference().child("rest");
    RestSearchRef.once().then((DataSnapshot SnapShot) {
      datalist.clear();
      var keys = SnapShot.value.keys;
      var values = SnapShot.value;
      for (var key in keys) {
        Data data = new Data(
          values[key]["restname"],
          values[key]["restemail"],
          values[key]["restaddress"],
          values[key]["restphone"],
          values[key]["userId"],
        );
        if (data.restname.contains(text)) {
          datalist.add(data);
        }
      }
      Timer(Duration(seconds: 1), () {
        setState(() {});
      });
    });
  }
}
