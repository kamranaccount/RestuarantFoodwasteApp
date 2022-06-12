import 'package:flutter/material.dart';
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
        title: const Text('Food Wastage Prediction'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Select correct answers from below:',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
                padding: EdgeInsets.all(8.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    onPressed: validateAnswers,
                    child: Text(
                      'Submit Form',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  RaisedButton(
                    onPressed: resetSelection,
                    child: Text(
                      'Clear',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16.0,
                          color: Colors.white),
                    ),
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
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
      Fluttertoast.showToast(
          msg: 'Please fill all options in form',
          toastLength: Toast.LENGTH_SHORT);
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
            title: const Text('Prediction Result'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Text("Wastage Prediction : "),
                    Text(result['percentage']),
                  ],
                ),
                Wrap(
                  runAlignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    const Text("Message : "),
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
                child: Text('Ok'),
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
