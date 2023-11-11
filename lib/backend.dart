import 'dart:convert';
import 'package:http/http.dart';

getUserInfo(int userId) async {
  String username = 'otp_rewind_client';
  String password = 'xENe5umCBvAUNBn';
  String basicAuth =
      'Basic ' + base64.encode(utf8.encode('$username:$password'));

  Response r = await get(Uri.parse('http://lucky42.duckdns.org:4224/$userId'),
      headers: <String, String>{'authorization': basicAuth});
  return r;
}


class User {
  int? id;
  String? name;
  String? country;
  String? birthdate;

  User(int id, String name, String country, String birthDate) {
    this.id = id;
    this.name = name;
    this.country=country;
    this.birthdate=birthDate;
  }
}

User fromJson(String jsonRaw)  {
  var data;
  data = jsonDecode(jsonRaw);

  return User(
      data['id'] as int,
      data['name'] as String,
      data['country'] as String,
      data['birthdate'] as String
  );
}