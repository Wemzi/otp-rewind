import 'dart:convert';
import 'package:http/http.dart';

getUserInfo(int userId) async {
  String username = 'otp_rewind_client';
  String password = 'xENe5umCBvAUNBn';
  String basicAuth = 'Basic ${base64.encode(utf8.encode('$username:$password'))}';
  var data;
  var extendedData;

  Response r = await get(Uri.parse('http://lucky42.duckdns.org:4224/$userId'),
      headers: <String, String>{'authorization': basicAuth});
  print(r.statusCode);
 if(r.statusCode!=200){
    data = jsonDecode('"id": 1,"name": "Kis János","country": "Hungary","birthdate": "1997-07-21","balance": 600000,"averageSpend":393232,"extendedDataYearly":{"favouriteCountry":"Croatia","visitedCountriesThisYear":7,"easiestMonth":5,"hardestMonth":1,"favouriteVendor":"Lidl","topFacts":[{"name":"Lidl","topPercentage":2,"amount":2332323,"type":"vendor"},{"name":"Croatia","topPercentage":19,"amount":2332323,"type":"country"},{"name":"Clothes","topPercentage":12,"amount":2332323,"type":"Category"]}}');
    extendedData = jsonDecode('{"averages":{"balance": 4342354,"averageSpend":344322,"favouriteCountry":"Croatia","visitedCountriesThisYear":2,"easiestMonth":12,"hardestMonth":1,"spentOnCategories":{"Clothing":147562,"Groceries":88630,"Going_out":54715,"Transport":12204,"HealthBeauty":48702,"Home":30332},"vendors":{"Tesco":50032,"Lidl":4000},"countries":{"Hungary":2421422,"Croatia":100032,"Germany":100032,"Austria":100032,"Georgia":100032,"Turkey":100032,"Denmark":100032}}');
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
      data['balance'] as String
  );
}

class User {
  int? id;
  String? name;
  String? country;
  String? birthdate;
  String? amount;
  ExtendedData? extendedData;

  User(int this.id, String this.name, String this.country,
      String this.birthdate, String this.amount);

  void loadExtendedData(Map<String,dynamic> extendedData)
  {
    this.extendedData = ExtendedData(extendedData);
  }
}

class ExtendedData{
  Map<String,dynamic> averages;
  ExtendedData(this.averages);
}