import 'package:flutter/material.dart';
import 'package:restaurantfoodwaste/Signup/signUpRest.dart';

class NearByRest extends StatefulWidget {
  const NearByRest({Key? key}) : super(key: key);

  @override
  _NearByRestState createState() => _NearByRestState();
}

class _NearByRestState extends State<NearByRest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("Near By Restaurants"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          child: Container(
            height: 200.0,
            width: 400,
            child: Column(
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "RESTAURANT NAME: Hot N Grill",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.green,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "Email: hotgrill@gmail.com",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Phone: +923057423695",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  "Address: Tariq Road ",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                      color: Colors.teal,
                      textColor: Colors.white,
                      child: Container(
                        height: 45.0,
                        child: Center(
                          child: Text(
                            "Request For Food",
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.white),
                      ),
                      onPressed: () {
                        displayToastMessage("In Progress", context);
                      }),
                ),
              ],
            ),
          ),
          elevation: 18,
          shadowColor: Colors.green,
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
