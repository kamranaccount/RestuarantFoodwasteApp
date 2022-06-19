import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:restaurantfoodwaste/Home_screen.dart';
import 'package:restaurantfoodwaste/Signup/signup_screen.dart';
import 'package:restaurantfoodwaste/all_screens/AddFood.dart';
import 'package:restaurantfoodwaste/all_screens/RestProfile.dart';
import 'package:restaurantfoodwaste/all_screens/RestViewHistory.dart';
import 'package:restaurantfoodwaste/all_screens/ViewFood.dart';
import 'package:restaurantfoodwaste/all_screens/ViewRequest.dart';
import 'package:restaurantfoodwaste/all_screens/prediction.dart';
import 'package:restaurantfoodwaste/all_screens/simpleMap.dart';
import 'package:flutter/src/widgets/container.dart';
import 'Data.dart';

class mainpagerest extends StatefulWidget {
  const mainpagerest({Key? key}) : super(key: key);

  @override
  _mainpagerestState createState() => _mainpagerestState();
}

class _mainpagerestState extends State<mainpagerest> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  var RestName, RestEmail, RestPhone, RestAddress;
  List<Data> dataList = [];
  int activeIndex = 0;
  bool searchState = false;
  TextEditingController controller = TextEditingController();
  String foodStatus = '';
  bool color = false;

  @override
  void initState() {
    // TODO: implement initState
    controller = TextEditingController();
    super.initState();
    DatabaseReference referenceData =
        FirebaseDatabase.instance.reference().child("ngos");
    referenceData.once().then((DataSnapshot dataSnapShot) {
      dataList.clear();
      var keys = dataSnapShot.value.keys;
      var values = dataSnapShot.value;

      for (var key in keys) {
        Data data = new Data(
          values[key]["ngoname"],
          values[key]["ngoemail"],
          values[key]["ngoaddress"],
          values[key]["ngophone"],
        );
        dataList.add(data);
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
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
                ? Text("Restaurants Screen")
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
                              image: AssetImage('images/restlogo.png')),
                        ),
                      ),
                      Text("Welcome Restaurant",
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
                    Icons.batch_prediction,
                    color: Colors.teal,
                  ),
                  title: Text("Prediction"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WastePrediction()),
                    );
                    displayToastMessage("Click On Prediction", context);
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
                          builder: (context) => RestViewHistory()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.request_page,
                    color: Colors.teal,
                  ),
                  title: Text("View Requests"),
                  onTap: () {
                    getRestProfile(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.fastfood,
                    color: Colors.teal,
                  ),
                  title: Text("Add Food"),
                  onTap: () {
                    //displayToastMessage("Click On History", context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddFood()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.fastfood_outlined,
                    color: Colors.teal,
                  ),
                  title: Text("View Food"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewFood()),
                    );
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
          body: dataList.length == 0
              ? Center(
                  child: Text(
                  "Data Not Found ...",
                  style: TextStyle(fontSize: 30),
                ))
              : ListView.builder(
                  itemCount: dataList.length,
                  itemBuilder: (_, index) {
                    return CardUI(
                      dataList[index].ngoname,
                      dataList[index].ngoemail,
                      dataList[index].ngoaddress,
                      dataList[index].ngophone,
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
                          builder: (context) => const mainpagerest()));
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

  Widget CardUI(
      String ngoname, String ngoemail, String ngoaddress, String ngophone) {
    return SingleChildScrollView(
      child: Center(
          child: Container(
        width: double.infinity,
        padding: new EdgeInsets.all(8.0),
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
              children: [
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  child: Text(
                    "NGO's: ${ngoname}",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.double,
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
                    Text("Email: ${ngoemail}"),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Address: ${ngoaddress}"),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("Phone: ${ngophone}"),
                    SizedBox(
                      height: 12.0,
                    ),
                    Text(
                      "Message: ",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      "To donate Food to NGO. Contact on this Details ",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey.shade800),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<void> getRestProfile(BuildContext context) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    String userId = firebaseUser.uid;
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("rest").child(userId);
    reference.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        RestName = snapshot.value['restname'];
        RestAddress = snapshot.value['restaddress'];
        RestEmail = snapshot.value['restemail'];
        RestPhone = snapshot.value['restphone'];
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => NgoReq(
                    RestName: RestName,
                    RestEmail: RestEmail,
                    RestPhone: RestPhone,
                    RestAddress: RestAddress,
                  )),
        );
        print('Rest Name: ${snapshot.value['restname']}');
        print('Rest Email: ${snapshot.value['restemail']}');
        print('Rest Address: ${snapshot.value['restaddress']}');
        print('Rest Phone: ${snapshot.value['restphone']}');
      } else {
        print("error");
      }
    });
  }

  Future<void> getCurrentUser(BuildContext context) async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    String userId = firebaseUser.uid;
    DatabaseReference reference =
        FirebaseDatabase.instance.reference().child("rest").child(userId);
    reference.once().then((DataSnapshot snapshot) {
      if (snapshot.value != null) {
        RestName = snapshot.value['restname'];
        RestAddress = snapshot.value['restaddress'];
        RestEmail = snapshot.value['restemail'];
        RestPhone = snapshot.value['restphone'];
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RestProfile(
                    getaddress: RestAddress,
                    getemail: RestEmail,
                    getname: RestName,
                    getphone: RestPhone,
                  )),
        );
        print('Rest Name: ${snapshot.value['restname']}');
        print('Rest Email: ${snapshot.value['restemail']}');
        print('Rest Address: ${snapshot.value['restaddress']}');
        print('Rest Phone: ${snapshot.value['restphone']}');
      } else {
        print("error");
      }
    });
  }

  Future<String?> showDialogStatus() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Enter Food Status"),
            content: TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(hintText: "AV/NA"),
              onSubmitted: (_) => update(),
            ),
            actions: [
              TextButton(onPressed: update, child: Text("UPDATE")),
            ],
          ));

  void update() {
    Navigator.of(context).pop(controller.text);
    controller.clear();
  }

  void SearchNgoMethod(String text) {
    DatabaseReference RestSearchRef =
        FirebaseDatabase.instance.reference().child("ngos");
    RestSearchRef.once().then((DataSnapshot SnapShot) {
      dataList.clear();
      var keys = SnapShot.value.keys;
      var values = SnapShot.value;
      for (var key in keys) {
        Data data = new Data(
          values[key]["ngoname"],
          values[key]["ngoemail"],
          values[key]["ngoaddress"],
          values[key]["ngophone"],
        );
        if (data.ngoname.contains(text)) {
          dataList.add(data);
        }
      }
      Timer(Duration(seconds: 1), () {
        setState(() {});
      });
    });
  }
}
