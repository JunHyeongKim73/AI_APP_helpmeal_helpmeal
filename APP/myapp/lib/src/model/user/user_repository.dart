import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:myapp/src/model/troop/group.dart';

import 'user.dart';

class UserRepository {
  static Future<bool> checkUser(String email) async {
    final response = await http.post(
      Uri.parse('https://helpmeal.duckdns.org/users/checkEmailOverlap'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{'email': email}),
    );

    if (response.statusCode == 200) {
      print('checkCompleted');
      String text = jsonDecode(response.body)['result'];
      if (text == 'Overlapped') {
        return true;
      }
      return false;
    } else {
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
        'troop': user.groups!.troopMap,
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

  static Future<User> getUser(String email, String password) async {
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

    final body = jsonDecode(response.body);
    print(body);
    if (response.statusCode == 200) {
      print('Get Success');
      Map<String, dynamic> tokenData = Jwt.parseJwt(body['token']);
      return User(
        email: tokenData['email'],
        name: tokenData['name'],
        groups: Group.fromJson(body['troop']),
        allergyList: body['allergy'],
        isAdmin: tokenData['manageLevel'] == null ? 0 : 1,
      );
    } else if (response.statusCode == 400) {
      return User(messege: body['messege']);
    } else {
      throw Exception('failed');
    }
  }
}
