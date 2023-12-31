import 'dart:convert';

import 'package:http/http.dart' as http;
class ApiManager {
  final String baseUrl;
  ApiManager(this.baseUrl);

  Future<Map<String, dynamic>> fetchData(String endpoint, String message, String messageError) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));

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
}
