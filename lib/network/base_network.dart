import 'dart:convert';

import 'package:http/http.dart' as http;

class BaseNetwork {
  static const String baseUrl = 'https://dattebayo-api.onrender.com/';
  static Future<List<dynamic>> getData(String endpoint) async{
    final response = await http.get(Uri.parse(baseUrl + endpoint));

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      return data[endpoint] ?? [];
    }else{
      throw Exception("Failed to load data!");
    }
  }


static Future<Map<String, dynamic>> getDetailData(String endpoint, int id) async {
  try {
    final response = await http.get(Uri.parse('$baseUrl$endpoint/$id'));
    print("Full request URL: " + '$baseUrl$endpoint/$id');
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Data received: $data");
      return data is Map<String, dynamic> ? data : <String, dynamic>{};
    } else {
      throw Exception("Failed to load data! Status Code: ${response.statusCode}");
    } 
  } catch (e) {
    print("Error fetching data: $e");
    return {};
  }
}
 }
