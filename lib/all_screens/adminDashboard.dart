import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurantfoodwaste/Home_screen.dart';
import 'package:restaurantfoodwaste/all_screens/addminAddNgo.dart';
import 'package:restaurantfoodwaste/all_screens/adminAddRest.dart';
import 'package:restaurantfoodwaste/all_screens/adminProfile.dart';
import 'package:restaurantfoodwaste/all_screens/adminViewFeedback.dart';
import 'package:restaurantfoodwaste/all_screens/adminViewNgo.dart';
import 'package:restaurantfoodwaste/all_screens/adminViewRest.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class adminDashboard extends StatefulWidget {
  const adminDashboard({Key? key}) : super(key: key);

  @override
  _adminDashboardState createState() => _adminDashboardState();
}

class _adminDashboardState extends State<adminDashboard> {
  GlobalKey _NavKey = GlobalKey();

  var PagesAll = [
    adminDashboard(),
    adminViewNgo(),
    adminViewRest(),
    AdminProfile()
  ];

  var myindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "ADMIN SCREEN",
              style: TextStyle(color: Colors.white),
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminProfile()));
                },
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                )),
          ],
        ),
        backgroundColor: Colors.pink,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              color: Colors.pink,
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
                          image: AssetImage('images/admin.png')),
                    ),
                  ),
                  Text("Welcome Admin",
                      style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic)),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "Email: admin@gmail.com",
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.pink,
              ),
              title: Text("Profile"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AdminProfile()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.pink,
              ),
              title: Text("Add Ngo's"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const adminAddNgo()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.streetview,
                color: Colors.pink,
              ),
              title: Text("View Ngo's"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const adminViewNgo()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.pink,
              ),
              title: Text("Add Restaurants"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const adminAddRest()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.streetview,
                color: Colors.pink,
              ),
              title: Text("View Restaurants"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const adminViewRest()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.feedback,
                color: Colors.pink,
              ),
              title: Text("View Feedbacks"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => adminViewFedBck()),
                );
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.pink,
              ),
              title: Text("Logout"),
              onTap: () {
                //displayToastMessage("Click On History", context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          print("Back Button Pressed!!");
          final PopUpMsg = await WarningMsg(context);
          return PopUpMsg ?? false;
        },
        child: SingleChildScrollView(
          child: Container(
              child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 8.0,
                ),
                Container(
                  width: 650.0,
                  child: Lottie.network(
                      'https://assets3.lottiefiles.com/packages/lf20_0pfddxbb.json',
                      animate: true),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 400.0,
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 1.0,
                          ),
                          Container(
                            height: 120.0,
                            child: Lottie.network(
                                'https://assets5.lottiefiles.com/packages/lf20_udTJtk.json',
                                animate: true),
                          ),
                          InkWell(
                            child: Text(
                              "NGO's",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      transitionDuration: Duration(seconds: 2),
                                      transitionsBuilder: (context, animation,
                                          animationTime, child) {
                                        animation = CurvedAnimation(
                                            parent: animation,
                                            curve:
                                                Curves.fastLinearToSlowEaseIn);
                                        return ScaleTransition(
                                          scale: animation,
                                          alignment: Alignment.center,
                                          child: child,
                                        );
                                      },
                                      pageBuilder:
                                          (context, animation, animationTime) {
                                        return adminViewNgo();
                                      }));
                            },
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            "Save Food & Save Life",
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            height: 120.0,
                            child: Lottie.network(
                                'https://assets2.lottiefiles.com/private_files/lf30_y0m027fl.json',
                                animate: true),
                          ),
                          InkWell(
                            child: Text(
                              "Restaurants",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                      transitionDuration: Duration(seconds: 2),
                                      transitionsBuilder: (context, animation,
                                          animationTime, child) {
                                        animation = CurvedAnimation(
                                            parent: animation,
                                            curve:
                                                Curves.fastLinearToSlowEaseIn);
                                        return ScaleTransition(
                                          scale: animation,
                                          alignment: Alignment.center,
                                          child: child,
                                        );
                                      },
                                      pageBuilder:
                                          (context, animation, animationTime) {
                                        return adminViewRest();
                                      }));
                            },
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            "Good Food Is Good Mood",
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0),
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          SizedBox(
                            height: 15.0,
                          ),
                        ],
                      ),
                      elevation: 18,
                      shadowColor: Colors.blue,
                      shape: BeveledRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        key: _NavKey,
        items: [
          Icon(
            Icons.home,
            color: Colors.white,
          ),
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite,
            color: Colors.white,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
          )
        ],
        buttonBackgroundColor: Colors.black,
        onTap: (index) {
          setState(() {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => adminDashboard()),
              );
            } else if (index == 1) {
            } else if (index == 2) {
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminProfile()),
              );
            }
          });
        },
        animationCurve: Curves.fastLinearToSlowEaseIn,
        color: Colors.pink,
      ),
    );
  }

  Future<bool?> WarningMsg(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Do you want to exit from app?",
            style: TextStyle(color: Colors.lightBlueAccent, fontSize: 18.0),
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
}
