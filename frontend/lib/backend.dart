import 'dart:convert';
import 'package:http/http.dart';

getUserInfo(int userId) async {
  String username = 'otp_rewind_client';
  String password = 'xENe5umCBvAUNBn';
  String basicAuth = 'Basic ${base64.encode(utf8.encode('$username:$password'))}';

  Response r = await get(Uri.parse('http://lucky42.duckdns.org:4224/$userId'),
      headers: <String, String>{'authorization': basicAuth});
   if(r.statusCode!=200)
    {
      throw Exception("The server did not react with the expected return code.");
    }
  var data = jsonDecode(r.body);



  //fallback  code if the server is not available
  //var data = jsonDecode('{"id":"1","name":"Kis János","country":"Hungary","birthdate":"1997-07-21"}');

  //TODO: convert names into utf8, áéiőű doesn't arrive right (issue could be on server side)
  return User(
      data['id'] as int,
      data['name'] as String,
      data['country'] as String,
      data['birthdate'] as String
  );
}


class User {
  int? id;
  String? name;
  String? country;
  String? birthdate;

  User(int this.id, String this.name, String this.country,
      String this.birthdate);
}

User? currentUser;