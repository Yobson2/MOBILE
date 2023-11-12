import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ApiManager {
  final String baseUrl="http://192.168.1.107:8082/apiNotabene/v1";
  final String baseUrlImage="http://192.168.1.107:8082";

   static String get apiKey => 'AIzaSyCRD-FSgdo6Tcpoj-RTuLQfmERxBagzm04';
   static String get apiUrl =>'https://maps.googleapis.com/maps/api/place/textsearch/json?query';
  ApiManager();

  Future<Map<String, dynamic>> fetchData(String endpoint, String message, String messageError) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
       print(message);
      return json.decode(response.body);
     
    } else {
      throw Exception(messageError);
    }
  }
  Future<Map<String, dynamic>> deleteData(String endpoint, String message, String messageError) async {
    final response = await http.delete(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
       print(message);
      return json.decode(response.body);
     
    } else {
      throw Exception(messageError);
    }
  }

  Future<Map<String, dynamic>> postData(String endpoint, Map<String, dynamic> data, String message, String messageError) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      print(message);
      return json.decode(response.body);
    } else {
      throw Exception(messageError);
    }
  }
  Future<Map<String, dynamic>> postMultiData(String endpoint, Map<String, dynamic> data, String message, String messageError) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    

    if (response.statusCode == 201) {
      print(message);
      return json.decode(response.body);
    } else {
      throw Exception(messageError);
    }
  }



  Future<String> loginUserAndGetToken(String endpoint,Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var myToken = jsonResponse['token'];
      return myToken;
    } else {
      throw Exception('Erreur lors de la connexion : ${response.statusCode}');
    }
  }



  void clearTextControllers(List<TextEditingController> controllers, TextEditingController emailController, TextEditingController passwordController) {
  for (var controller in controllers) {
    controller.clear();
  }
}


}
