import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

import 'user.dart';

class UserRepository {
  static Future<bool> checkUser(String email) async {
    final response = await http.post(
      Uri.parse('https://helpmeal.duckdns.org/users/check'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email' : email
      }),
    );

    if(response.statusCode == 201){
      print('checkCompleted');
      print(jsonDecode(response.body));
      String text = jsonDecode(response.body)['result'];
      if(text == 'Overlapped'){
        return false;
      }
      return true;
    }
    else{
      throw Exception('check failed');
    }
  }

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
        'managerLevel': user.isAdmin,
      }),
    );
    if (response.statusCode == 201) {
      print('POST Completed!');
      print(jsonDecode(response.body));
    } else {
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

    if (response.statusCode == 201) {
      print('Get Success');
      // print(UserForGet.fromJson(jsonDecode(response.body)));
      // UserForGet userForGet = UserForGet.fromJson(jsonDecode(response.body));

      // Map<String, dynamic> payload = Jwt.parseJwt(userForGet.token);

      // print(payload);
    } else {
      throw Exception('failed');
    }
  }
}

class UserForGet {
  final String result;
  final String token;

  UserForGet({required this.result, required this.token});

  factory UserForGet.fromJson(Map<String, dynamic> json) {
    return UserForGet(result: json['result'], token: json['token']);
  }
}
