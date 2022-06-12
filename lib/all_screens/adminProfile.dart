import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurantfoodwaste/Home_screen.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  _AdminProfileState createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink.shade50,
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Admin Profile",
                style: TextStyle(color: Colors.white),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 80.0,
                  ),
                  Container(
                    width: 150,
                    child: Lottie.network(
                      'https://assets9.lottiefiles.com/datafiles/i1uFIojbGt3KRN2/data.json',
                      animate: true,
                    ),
                    alignment: Alignment.center,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Text(
                      "ADMIN PROFILE",
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink[900],
                        letterSpacing: 1.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 14.0,
                  ),
                  Card(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(
                        color: Colors.pink,
                      ),
                    ),
                    shadowColor: Colors.pink,
                    elevation: 15,
                    child: Container(
                      margin: EdgeInsets.all(3.5),
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                              "Admin ID : 231754",
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14.0,
                  ),
                  Card(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(
                        color: Colors.pink,
                      ),
                    ),
                    shadowColor: Colors.pink,
                    elevation: 15,
                    child: Container(
                      margin: EdgeInsets.all(3.5),
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                              "Email: admin@gmail.com",
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14.0,
                  ),
                  Card(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(
                        color: Colors.pink,
                      ),
                    ),
                    shadowColor: Colors.pink,
                    elevation: 15,
                    child: Container(
                      margin: EdgeInsets.all(3.5),
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 8.0,
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                              "Username : Admin",
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
