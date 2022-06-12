import 'dart:async';

import 'package:flutter/material.dart';

class timer extends StatefulWidget {
  const timer({Key? key}) : super(key: key);

  @override
  _timerState createState() => _timerState();
}

class _timerState extends State<timer> {
  int start = 30;
  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
          text: "send OTP again in ",
          style: TextStyle(fontSize: 16.0, color: Colors.grey.shade900),
        ),
        TextSpan(
          text: "00:$start",
          style: TextStyle(
              fontSize: 16.0, color: Colors.teal, fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: " sec ",
          style: TextStyle(fontSize: 16.0, color: Colors.grey.shade900),
        ),
      ])),
    );
  }
}
