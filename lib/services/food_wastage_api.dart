import 'dart:convert';

import 'package:http/http.dart' as http;

class FoodWastageAPI {
  static const String baseUrl = 'http://10.0.2.2:5000/api/v1/food_wastage/';

  static Future<Map> predictFoodWastage(int p1, int p2, int p3, int p4) async {
    try {
      var url = Uri.parse(baseUrl + 'prediction/?p1=$p1&p2=$p2&p3=$p3&p4=$p4');
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      return json.decode(response.body);
    } catch (e) {
      print(e);
      return {};
    }
  }
}
