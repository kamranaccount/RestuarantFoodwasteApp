import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:restaurantfoodwaste/all_screens/ngoAcceptedRequest.dart';
import 'package:restaurantfoodwaste/all_screens/showFoodDetails.dart';
import 'package:restaurantfoodwaste/Signup/signup_screen.dart';
import 'package:restaurantfoodwaste/all_screens/NgoConfirmReq.dart';

class showFoodDetails extends StatefulWidget {
  final String showName, showEmail;
  final userId;

  showFoodDetails(
      {Key? key,
      required this.showName,
      required this.showEmail,
      required this.userId})
      : super(key: key);

  @override
  _showFoodDetailsState createState() => _showFoodDetailsState();
}

class _showFoodDetailsState extends State<showFoodDetails> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final String email = FirebaseAuth.instance.currentUser!.email.toString();
  late String getresponse, getcomment;
  late DatabaseReference show_food;
  var ReqName, ReqEmail, ReqPhone, ReqAddress;

  @override
  void initState() {
    show_food = FirebaseDatabase.instance
        .reference()
        .child("rest")
        .child(widget.userId.toString())
        .child("food");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Details"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 280,
                  child: Card(
                    child: Image.asset(
                      'images/restpic.png',
                      fit: BoxFit.cover,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  "NAME: ${widget.showName}",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "EMAIL: ${widget.showEmail}",
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
                FirebaseAnimatedList(
                  physics: NeverScrollableScrollPhysics(),
                  query: show_food,
                  shrinkWrap: true,
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
                            Text(
                                "FOOD STATUS: ${snapshot.value['foodStatus']}"),
                            SizedBox(
                              height: 10.0,
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
                SizedBox(
                  height: 12.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                      color: Colors.teal,
                      textColor: Colors.white,
                      child: Container(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              "Send Request For Food",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
//<<<<<<< Updated upstream

                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white),
                      ),
                      onPressed: () {
                        //show();
                      }),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                    color: Colors.teal,
                    textColor: Colors.white,
                    child: Container(
                      height: 45.0,
                      child: Center(
                        child: Text(
                          "Show accept request",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => showAcceptRequest(
                                    uid: widget.userId,
                                  )));
                    }),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                    color: Colors.teal,
                    textColor: Colors.white,
                    child: Container(
                      height: 45.0,
                      child: Center(
                        child: Text(
                          "Send Request For Food",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.white),
                    ),
                    onPressed: () {
                      ReqCurrentNgo(context);
                    })
              ],
            ),
          ),
        ),
      ),
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
        ReqAddress = snapshot.value['ngoaddress'];
        ReqEmail = snapshot.value['ngoemail'];
        ReqPhone = snapshot.value['ngophone'];
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ngoConfirmReq(
                    showReqAddr: ReqAddress,
                    showReqEmail: ReqEmail,
                    showReqName: ReqName,
                    showReqPhn: ReqPhone,
                    restId: widget.userId,
                  )),
        );
        print('Requester Name: ${ReqName}');
      } else {
        print("error");
      }
    });
  }
}
