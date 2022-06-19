import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurantfoodwaste/all_screens/mainpage.dart';
import 'package:restaurantfoodwaste/main.dart';

class ngoConfirmReq extends StatefulWidget {
  final String showReqName, showReqEmail, showReqAddr, showReqPhn, restId;

  const ngoConfirmReq(
      {Key? key,
      required this.showReqName,
      required this.showReqAddr,
      required this.showReqEmail,
      required this.showReqPhn,
      required this.restId})
      : super(key: key);

  @override
  _ngoConfirmReqState createState() => _ngoConfirmReqState();
}

class _ngoConfirmReqState extends State<ngoConfirmReq> {
  late DatabaseReference request;

  @override
  void initState() {
    request = FirebaseDatabase.instance
        .reference()
        .child("rest")
        .child(widget.restId.toString())
        .child("request");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Confirm Request",
          style: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'images/sendreq.png',
                  scale: 1,
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: Column(children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.all(20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15)),
                                  color: Colors.teal,
                                ),
                                width: 400,
                                height: 50.0,
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Confirmation Request',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "NGO Name: ${widget.showReqName}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 27.0),
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Text(
                                      " We are confirming that are you sure you want to raise a  for food. This this request will be shown to each of the restaurants and the restaurants who wants to donate the food will accept your request. If the restaurants wants to approach you for donating the food , the request that you have send will be confirmed by email through this you will be able to know that your request is accepted. Thank you for using our app",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RaisedButton(
                                        color: Colors.white,
                                        child: Container(
                                          height: 55.0,
                                          width: 100.0,
                                          child: Center(
                                            child: Text(
                                              "CANCEL",
                                              style: TextStyle(
                                                color: Colors.teal,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(5.0),
                                          side: BorderSide(color: Colors.teal),
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const mainpage()),
                                          );
                                        }),
                                    RaisedButton(
                                        color: Colors.teal,
                                        child: Container(
                                          height: 55.0,
                                          width: 100.0,
                                          child: Center(
                                            child: Text(
                                              "CONFIRM",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(5.0),
                                          side: BorderSide(color: Colors.teal),
                                        ),
                                        onPressed: () {
                                          request.push().set({
                                            'reqngoname': widget.showReqName,
                                            'reqngoemail': widget.showReqEmail,
                                            'reqngophone': widget.showReqPhn,
                                            'reqngoaddr': widget.showReqAddr,
                                          }).then((value) => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      mainpage())));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                            " Request is sent Successfully",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 20.0),
                                          )));
                                        }),
                                  ],
                                ),
                              ),
                            ])),
                  ]),
                ) ////
              ],
            ),
          ),
        ),
      ),
    );
  }
}
