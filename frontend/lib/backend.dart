import 'dart:convert';
import 'package:http/http.dart';

getUserInfo(int userId) async {
  String username = 'otp_rewind_client';
  String password = 'xENe5umCBvAUNBn';
  String basicAuth = 'Basic ${base64.encode(utf8.encode('$username:$password'))}';
  var data;
  var extendedData;
  var data_fallback = jsonDecode('{"id":1,"name":"Kis János","country":"Hungary","birthdate":"1997-07-21","balance":600000,"averageSpend":393232,"extendedDataYearly":{"favouriteCountry":"Croatia","visitedCountriesThisYear":7,"easiestMonth":5,"hardestMonth":1,"favouriteVendor":"Lidl","topFacts":[{"name":"Lidl","topPercentage":2,"amount":2332323,"type":"vendor"},{"name":"Croatia","topPercentage":19,"amount":2332323,"type":"country"},{"name":"Clothes","topPercentage":12,"amount":2332323,"type":"Category"}]}}');
  var extendedData_fallback = jsonDecode('{"averages":{"balance": 4342354,"averageSpend":344322,"favouriteCountry":"Croatia","visitedCountriesThisYear":2,"easiestMonth":12,"hardestMonth":1,"spentOnCategories":{"Clothing":147562,"Groceries":88630,"Going_out":54715,"Transport":12204,"HealthBeauty":48702,"Home":30332},"vendors":{"Tesco":50032,"Lidl":4000},"countries":{"Hungary":2421422,"Croatia":100032,"Germany":100032,"Austria":100032,"Georgia":100032,"Turkey":100032,"Denmark":100032}}}');
  Response? r;
  try{
   //   r = await get(Uri.parse('http://lucky42.duckdns.org:4224/$userId'),
   //     headers: <String, String>{'authorization': basicAuth});
   //     print(r.statusCode);
  } on Exception catch (_) {}
  if(r == null || r!.statusCode <200 || r!.statusCode >300) {
    data = data_fallback;
    extendedData = extendedData_fallback;
  }
  else{
    data = jsonDecode(r!.body);
  }

  //TODO: convert names into utf8, áéiőű doesn't arrive right (issue could be on server side)
  //TODO: or don't use hungarian characters in demo
  User retVal = User(
      data['id'] as int,
      data['name'] as String,
      data['country'] as String,
      data['birthdate'] as String,
      data['balance'] as int,
      data['averageSpend'] as int
  );
 print(retVal.name);
 retVal.loadExtendedData(extendedData);
 return retVal;
}

class User {
  int? id;
  String? name;
  String? country;
  String? birthdate;
  int? balance;
  int? avgSpend;
  ExtendedData? extendedData;

  User(int this.id, String this.name, String this.country,
      String this.birthdate, int this.balance, int this.avgSpend);

  void loadExtendedData(Map<String,dynamic> extendedData)
  {
    this.extendedData = ExtendedData(extendedData);
  }
}


//TODO: implement so it parses data into properties, input example is in userdata_example.json and variables "data" and "extendedData"
class ExtendedData{
  Map<String,dynamic> averages;
  ExtendedData(this.averages);
}

User? currentUser;