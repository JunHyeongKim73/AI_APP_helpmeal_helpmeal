import 'dart:convert';
import 'package:http/http.dart' as http;

import 'user.dart';

class UserRepository {
  
  static Future<void> postUser(User user) async {
    final response = await http.post(
      Uri.parse('https://helpmeal.duckdns.org/users/new'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': user.name,
        'password': user.password,
        'military_serial_number': user.milNum,
        'troopId': 1,
        'email': user.email,
        'allergy': user.allergyList,
        'managerLevel' : user.isAdmin,
      }),
    );
    if (response.statusCode == 201) {
      print('POST Completed!');
      print(jsonDecode(response.body));
    } else{
      throw Exception('failed');
    }
  }

  static Future<void> getUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://helpmeal.duckdns.org/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'password': password,
      }),
    );

    print(response.statusCode);
    print(jsonDecode(response.body));

    if(response.statusCode == 201){
      print('Get Success');
    }
    else{
      throw Exception('failed');
    }
  }
}
