import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:restaurantfoodwaste/Signup/signup_screen.dart';
import 'package:restaurantfoodwaste/all_screens/NgoConfirmReq.dart';

class showFoodDetails extends StatefulWidget {
  final String showName, showEmail;

  showFoodDetails({Key? key, required this.showName, required this.showEmail})
      : super(key: key);

  @override
  _showFoodDetailsState createState() => _showFoodDetailsState();
}

class _showFoodDetailsState extends State<showFoodDetails> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final String email = FirebaseAuth.instance.currentUser!.email.toString();
  late String getresponse, getcomment;
  var ReqName, ReqEmail, ReqPhone, ReqAddress;
  //late String Email = 'kamranyaqoob1206@gmail.com';
  // late String Pass = 'kam181218';
  TextEditingController Email = TextEditingController();
  TextEditingController Pass = TextEditingController();
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
                          "Give Feedback",
                          style: TextStyle(color: Colors.white, fontSize: 20.0),
                        ),
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white),
                    ),
                    onPressed: () {
                      show();
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
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.white),
                    ),
                    onPressed: () {
                      ReqCurrentNgo(context);
                    }),
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
                  )),
        );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => mainpage()),
        // );
        print('Requester Name: ${ReqName}');
      } else {
        print("error");
      }
    });
  }

  void show() {
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
                //sendmail();
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
                  openDialog();
                }
                // print("OnSubmittedRating: ${response.rating}");
                // print("comment: ${response.comment}");
              });
        });
  }

  sendmail() async {
    final smtpServer = gmail(Email.text, Pass.text);
    final message = Message()
      ..from = Address(Email.text)
      ..recipients.add(widget.showEmail)
      ..subject = 'Feedback From NGO :: 😀 :: ${DateTime.now()}'
      ..text = 'Rating ${getresponse} and Comment is ${getcomment}'
      ..html =
          "<h1>Feedback</h1>\n<p>Rating is: ${getresponse}</p>\n<p>Comment is: ${getcomment}</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Email Sent Successfuly",
        style: TextStyle(
            color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18.0),
      )));
    } on MailerException catch (e) {
      print('Message not sent.');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Email Not Sent",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18.0),
      )));
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Something Went Wrong..",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18.0),
        )));
      }
    }
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            'Enter Your Gmail Account Details',
            style: TextStyle(color: Colors.teal),
          ),
          content: Container(
            height: 100.0,
            child: Column(
              children: [
                TextField(
                  controller: Email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Email',
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal,
                        width: 2,
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                TextField(
                  controller: Pass,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter Your Password',
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.teal,
                        width: 2,
                      ),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (Email.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    "Please Enter Email",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  )));
                  displayToastMessage("Please Enter Email", context);
                } else if (!Email.text.contains('@')) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    "Email is Invalid",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  )));
                } else if (Pass.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    "Please Enter Password",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  )));
                  displayToastMessage("Please Enter Password", context);
                } else {
                  sendmail();
                }
              },
              child: Text(
                'Send Email',
                style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
              ),
            ),
          ],
        ),
      );
}
