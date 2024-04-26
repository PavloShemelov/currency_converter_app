import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const request = 'https://api.hgbrasil.com/finance?key=df69b4ac';

Future<Map<String, dynamic>?> getData() async {
  var response = await http.get(Uri.parse(request));
  if (response.statusCode == 200) {
    return json.decode(response.body) as Map<String, dynamic>?;
  } else {
    throw Exception('Failed to load data');
  }
}
