import 'dart:convert';

import 'package:app/Model/Data.dart';
import 'package:http/http.dart' as http;
class Repository{
  String url="http://10.0.2.2:5000/result";
  Future<double> getPredictedData(Data data)async{
    print("Hi1023");
    var response = await http.post(Uri.parse(url),body:jsonEncode(<String, dynamic> {
      "bhk_no":data.bhk,
      "sqft":data.sqft,
      "resale":data.resale,
      "long":data.long,
      "lat":data.lat
    }),headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });
    print(response.statusCode);
    var json=jsonDecode(response.body);
    print("oojo");
    return json['predicted'];
  }
}