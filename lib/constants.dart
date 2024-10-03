import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Constants {
  static Color primaryColor = Colors.blue;
  static Color secondaryColor = Colors.deepPurple;
  static Color liteColor = Colors.white;
  static Color darkColor = Colors.black;
}

List newsListimage = [
  {"image": "image1.jpg"},
  {"image": "image1.jpg"},
  {"image": "image1.jpg"},
  {"image": "image1.jpg"},
  {"image": "image2.jpg"},
  {"image": "image3.jpg"},
  {"image": "image2.jpg"},
  {"image": "image3.jpg"},
  {"image": "image2.jpg"},
  {"image": "image3.jpg"},
  {"image": "image2.jpg"},
  {"image": "image3.jpg"},
  {"image": "image2.jpg"},
  {"image": "image3.jpg"},
  {"image": "image2.jpg"},
  {"image": "image3.jpg"},
  {"image": "image2.jpg"},
  {"image": "image3.jpg"},
  {"image": "image2.jpg"},
  {"image": "image3.jpg"},
];

class Crud {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error Catch $e");
    }
  }

  postRequest(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error Catch $e");
    }
  }
}
