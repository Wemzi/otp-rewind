import 'dart:convert';
import 'package:http/http.dart';

getUserInfo(int userId) async {
  String username = 'otp_rewind_client';
  String password = 'xENe5umCBvAUNBn';
  String basicAuth = 'Basic ${base64.encode(utf8.encode('$username:$password'))}';
  var data;

  Response r = await get(Uri.parse('http://lucky42.duckdns.org:4224/$userId'),
      headers: <String, String>{'authorization': basicAuth});
  print(r.statusCode);
 if(r.statusCode!=200){
    data = jsonDecode('{"id":"1","name":"Kis János","country":"Hungary","birthdate":"1997-07-21","amount":"600.000Ft"}');
 }
 else{
   data = jsonDecode(r.body);
 }




  //fallback  code if the server is not available


  //TODO: convert names into utf8, áéiőű doesn't arrive right (issue could be on server side)
  return User(
      data['id'] as int,
      data['name'] as String,
      data['country'] as String,
      data['birthdate'] as String,
      data['Amount'] as String
  );
}


class User {
  int? id;
  String? name;
  String? country;
  String? birthdate;
  String? amount;
  String? extendedData; // todo: figure out format and therefore proper type

  User(int this.id, String this.name, String this.country,
      String this.birthdate, String this.amount);

  void loadExtendedData(String extendedData)
  {
    this.extendedData = extendedData;
  }
}

User? currentUser;