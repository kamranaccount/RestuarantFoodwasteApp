import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurantfoodwaste/services/food_wastage_api.dart';

class WastePrediction extends StatefulWidget {
  const WastePrediction({Key? key}) : super(key: key);

  @override
  _WastePredictionState createState() => _WastePredictionState();
}

class _WastePredictionState extends State<WastePrediction> {
  int _radioValue1 = -1;
  int _radioValue2 = -1;
  int _radioValue3 = -1;
  int _radioValue4 = -1;

  List<String> questions = [
    '1. How your restaurant manages its food waste?',
    '2. Due to lack of chief experience your restaurant faces wastage problems?',
    '3. How many times your restaurant have to face last minutes changes?',
    '4. How many times food is leftover by the customer?',
  ];

  void _handleRadioValueChange1(int? value) {
    setState(() {
      _radioValue1 = value!;
    });
  }

  void _handleRadioValueChange2(int? value) {
    setState(() {
      _radioValue2 = value!;
    });
  }

  void _handleRadioValueChange3(int? value) {
    setState(() {
      _radioValue3 = value!;
    });
  }

  void _handleRadioValueChange4(int? value) {
    setState(() {
      _radioValue4 = value!;
    });
  }

  Widget buildRadioButtons(
      int q_no, int radioGroup, void _handleRadioValueChange(int? value)) {
    return Column(
      children: [
        Text(
          questions[q_no],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        Wrap(
          runAlignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  value: 0,
                  groupValue: radioGroup,
                  onChanged: _handleRadioValueChange,
                ),
                Text(
                  'Always',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  value: 1,
                  groupValue: radioGroup,
                  onChanged: _handleRadioValueChange,
                ),
                Text(
                  'Frequently',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  value: 2,
                  groupValue: radioGroup,
                  onChanged: _handleRadioValueChange,
                ),
                Text(
                  'Never',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  value: 3,
                  groupValue: radioGroup,
                  onChanged: _handleRadioValueChange,
                ),
                Text(
                  'Occasionally',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Radio(
                  value: 4,
                  groupValue: radioGroup,
                  onChanged: _handleRadioValueChange,
                ),
                Text(
                  'Rarely',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ],
        ),
        Divider(
          height: 5.0,
          color: Colors.black,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Food Wastage Prediction',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Select correct answers from below:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              Divider(height: 5.0, color: Colors.black),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              buildRadioButtons(0, _radioValue1, _handleRadioValueChange1),
              buildRadioButtons(1, _radioValue2, _handleRadioValueChange2),
              buildRadioButtons(2, _radioValue3, _handleRadioValueChange3),
              buildRadioButtons(3, _radioValue4, _handleRadioValueChange4),
              Padding(
                padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 15.0, right: 15.0, bottom: 10.0),
                          child: Text(
                            "SUBMIT",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )),
                    onTap: validateAnswers,
                  ),
                  Padding(
                    padding: EdgeInsets.all(2.0),
                  ),
                  InkWell(
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 15.0, right: 15.0, bottom: 10.0),
                          child: Text(
                            "CLEAR",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        )),
                    onTap: resetSelection,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void resetSelection() {
    _handleRadioValueChange1(-1);
    _handleRadioValueChange2(-1);
    _handleRadioValueChange3(-1);
    _handleRadioValueChange4(-1);
  }

  void validateAnswers() async {
    if (_radioValue1 == -1 ||
        _radioValue2 == -1 ||
        _radioValue3 == -1 ||
        _radioValue4 == -1) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "Please Fill All Options In Form",
        style: TextStyle(
            color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18.0),
      )));
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      );
      Map result = await FoodWastageAPI.predictFoodWastage(
          _radioValue1, _radioValue2, _radioValue3, _radioValue4);

      if (result.isNotEmpty) {
        Navigator.pop(context);

        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => AlertDialog(
            title: const Text(
              'Prediction Result',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Text(
                      "Wastage Prediction : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(result['percentage']),
                  ],
                ),
                Wrap(
                  runAlignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    const Text(
                      "Message : ",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(result['message']),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  resetSelection();
                  Navigator.pop(context);
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.teal),
                ),
              )
            ],
          ),
        );
      } else {
        Navigator.pop(context);

        Fluttertoast.showToast(
            msg: 'Prediction Failed Server Error.',
            toastLength: Toast.LENGTH_SHORT);
      }
    }
  }
}
