import 'dart:convert';
import 'package:http/http.dart';

getUserInfo(int userId) async {
  String username = 'otp_rewind_client';
  String password = 'xENe5umCBvAUNBn';
  String basicAuth = 'Basic ${base64.encode(utf8.encode('$username:$password'))}';
  var data;
  var data_fallback = jsonDecode('{"currentUser":{"id": 1,"name": "Kis János","country": "Hungary","birthdate": "1997-07-21","balance": 600000,"averageSpend":393232,"extendedDataYearly":{"favouriteCountry":"Croatia","visitedCountriesThisYear":7,"easiestMonth":5,"hardestMonth":1,"favouriteVendor":"Lidl","topFacts":[{"name":"Lidl","topPercentage":2,"amount":2332323,"type":"vendor"},{"name":"Croatia","topPercentage":19,"amount":2332323,"type":"country"},{"name":"Clothes","topPercentage":12,"amount":2332323,"type":"Category"}]}},"averages":{"balance": 4342354,"averageSpend":344322,"favouriteCountry":"Croatia","visitedCountriesThisYear":2,"easiestMonth":12,"hardestMonth":1,"spentOnCategories":{"Clothing":147562,"Groceries":88630,"Going_out":54715,"Transport":12204,"HealthBeauty":48702,"Home":30332},"vendors":{"Tesco":50032,"Lidl":4000},"countries":{"Hungary":2421422,"Croatia":100032,"Germany":100032,"Austria":100032,"Georgia":100032,"Turkey":100032,"Denmark":100032}}}');
  Response? r;
  try{
   r = await get(Uri.parse('http://lucky42.duckdns.org:4224/$userId'),
   headers: <String, String>{'authorization': basicAuth});
   print(r.statusCode);
  } on Exception catch (_) {}

  if(r == null || r!.statusCode < 200 || r!.statusCode >300) {
    data = data_fallback;
  }
  else{
    data = jsonDecode(r!.body);
    print(data);
  }

  User retVal = User(
      data['currentUser']['id'] as int,
      data['currentUser']['name'] as String,
      data['currentUser']['country'] as String,
      data['currentUser']['birthdate'] as String,
      data['currentUser']['balance'] as int,
      data['currentUser']['averages']['averageSpend'] as int,
  );
 print(retVal.name);
 retVal.loadExtendedData(data_fallback);
 return retVal;
}

class User {
  int? id;
  String? name;
  String? country;
  String? birthdate;
  int? balance;
  int? avgSpend;
  Data? data;

  User(int this.id, String this.name, String this.country,
      String this.birthdate, int this.balance, int this.avgSpend);

  void loadExtendedData(Map<String,dynamic> recData)
  {
    data = Data(recData);
  }
}

class Data{
  Map<String,dynamic> json;
  Data(this.json);
}

User? currentUser;