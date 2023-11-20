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
  }

  User retVal = User(
      data['currentUser']['id'] as int,
      data['currentUser']['name'] as String,
      data['currentUser']['country'] as String,
      data['currentUser']['birthdate'] as String,
      data['currentUser']['balance'] as int,
      (data['currentUser']['averages']['averageSpend'] as double).round(),
      data
  );
 return retVal;
}

enum Type{
  VENDOR,
  COUNTRY,
  CATEGORY,
  UNKNOWN
}

Type getType(String type)
{
  switch(type){
    case "vendor":
      return Type.VENDOR;
    case "country":
      return Type.COUNTRY;
    case "category":
      return Type.CATEGORY;
    default:
      return Type.UNKNOWN;
  }
}

class User {
  int? id;
  String? name;
  String? country;
  String? birthdate;
  int? balance;
  int? avgSpend;
  Data? data;
  List<Content> storyContent = [];

  User(int this.id, String this.name, String this.country, String this.birthdate, int this.balance, int this.avgSpend, inJson){
    data = Data(inJson);
    for(var element in data!.json['currentUser']['extendedDataYearly']['topFacts']) {
      var content = Content(name: element['name'],
          percentage: element['topPercent'],
          amount: element['amount'],
          type: getType(element['type']));
      content.updateContentTexts();
      storyContent.add(content);
    }
  }
}

class Data{
  Map<String,dynamic> json;
  Data(this.json);
}

User? currentUser;

class Content{
  String? informationText;
  String? informationPlusInfo;
  String? statText;
  final String name;
  final double percentage;
  final int amount;
  final Type type;

  Content({
    required this.name,
    required this.percentage,
    required this.amount,
    required this.type,
  });

  void updateContentTexts()
  {
    switch(type){
      case Type.VENDOR:
        informationText = "KEDVENC KERESKEDŐ\n$name";
        informationPlusInfo = '"Ebben a hónapban kimagaslóan sokat jártál kedvenc élelmiszerüzletláncodba. Ez 120%-al nagyobb költés mint előző hónapban."'; //TODO AI??
        statText = "Legmagasabb ${percentage}%";
      case Type.CATEGORY:
        informationText = "KEDVENC KATEGÓRIA\n$name";
        informationPlusInfo = "IDE GENERÁLUNK AI-VAL IDE GENERÁLUNK AI-VAL SZÖVEGET MAJD SZÖVEGET MAJDIDE GENERÁLUNK AI-VAL SZÖVEGET MAJD\nIDE GENERÁLUNK AI-VAL SZÖVEGET MAJD\nIDE GENERÁLUNK AI-VAL SZÖVEGET MAJD\nIDE GENERÁLUNK AI-VAL SZÖVEGET MAJD\nIDE GENERÁLUNK AI-VAL SZÖVEGET MAJD\n";
        statText = "Legmagasabb ${percentage}%";
      case Type.COUNTRY:
        informationText = "KEDVENC ORSZÁG\n$name";
        informationPlusInfo = "IDE GENERÁLUNK AI-VAL SZÖVEGET MAJDIDE GENERÁLUNK AI-VAL SZÖVEGET MAJDIDE GENERÁLUNK AI-VAL SZÖVEGET MAJD\nIDE GENERÁLUNK AI-VAL SZÖVEGET MAJD\nIDE GENERÁLUNK AI-VAL SZÖVEGET MAJD\n";
        statText = "Legmagasabb ${percentage}%";
      default:
        break;
    }
  }

}