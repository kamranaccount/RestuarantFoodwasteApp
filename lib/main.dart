import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:restaurantfoodwaste/loginscren/loginScrn.dart';
import 'package:restaurantfoodwaste/otpscreen/otpverify.dart';
import 'package:restaurantfoodwaste/splashScreen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> main() async {
  //help to intilaze external lib
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AwesomeNotifications().initialize("ic_launcher", [
    NotificationChannel(
      channelKey: "Key1",
      channelName: "Restaurant food waste App",
      channelDescription: "Notification ",
      defaultColor: Colors.teal,
      ledColor: Colors.white,
      playSound: true,
      enableLights: true,
      enableVibration: true,
    )
  ]);
  runApp(MyApp());
}

//for saving user info
//when ever we need to call user ref we can call anywhere thats why we use in main file

DatabaseReference ngos_ref =
    FirebaseDatabase.instance.reference().child("ngos");
DatabaseReference rest_ref =
    FirebaseDatabase.instance.reference().child("rest");
DatabaseReference ngo_send_req =
    FirebaseDatabase.instance.reference().child("ngosendreq");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashscreen(),
    );
  }
}

void OTPNotify() async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'Key1',
          title: 'Restaurants Food Waste App',
          body: 'We have sent you OTP Code on Email'));
}
