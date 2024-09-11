import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<dynamic>> apiGetData() async{
  var response = await http.get(Uri.parse("https://bearbyz.github.io/weather.json"));
  if(response.statusCode == 200){
    var map = jsonDecode(response.body) as List<dynamic>;
    return map;
  }else{
    throw Exception("Error");
  }
}

