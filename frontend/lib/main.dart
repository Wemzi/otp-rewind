import 'package:flutter/material.dart';
import 'package:http/http.dart';
import "backend.dart" as backend;

void main() {
  runApp(const OTPRewind());
}


final lightGreen = Colors.green.shade300;
final mediumGreen = Colors.green.shade600;
final darkGreen = Colors.green.shade900;
const colorOTPgreen = Color.fromARGB(255, 106, 172, 69);
const colorOTPgrey = Color.fromARGB(255, 167, 172, 184);
const colorOTPwhite = Color.fromARGB(255, 250, 251, 252);
const colorOTPdarkGrey = Color.fromARGB(255, 42, 43, 46);

class OTPRewind extends StatelessWidget {
  const OTPRewind({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTP Rewind',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OTPAppPage(title: 'OTP Rewind Demo'),
    );
  }
}

class OTPAppPage extends StatefulWidget {
  const OTPAppPage({super.key, required this.title});


  final String title;

  @override
  State<OTPAppPage> createState() => MainPage();
}

/*class OpeningPage extends StatefulWidget {

  @override
  State<OpeningPage> createState() => _OpeningPageState();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            MyBox(darkGreen,height: 50),
          ],
        ),
        Row(
          children: [
            MyBox(lightGreen),
            MyBox(lightGreen),
          ],
        ),
        MyBox(mediumGreen, insideText: Text(backend.currentUser == null ? "" : '${backend.currentUser!.name}', style:const TextStyle(color: Colors.white,fontSize:30))),
        Row(
          children: [
            MyBox(lightGreen, height: 200),
            MyBox(lightGreen, height: 200),
          ],
        ),
      ],
    );
  }
}


//Contains balance info, account holder name, OTP Rewind button.
  final _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top:45)),
        MyBox(lightGreen, height: 100,
          insideText: const Text('Sok volt a nyaralás...',
          style: TextStyle(color:Colors.white,fontSize:35))
        ),
        MyBox(mediumGreen, height: 200,
    insideText: Text(backend.currentUser == null ? "" :
                                '${backend.currentUser!.name}')),
      ],
    );
  }
}*/

class RewindStartupPage extends StatelessWidget {
  const RewindStartupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top:45)),
        Row(
          children: [
            MyBox(lightGreen, insideText: Text('IDEJE  \nVISSZATEKINTENI.',style: const TextStyle(color:Colors.white,fontSize:35)))
          ],
        ),
        Image.asset("resources/images/rewind_icon.png"),
        Row(
          children: [
            MyBox(lightGreen, height: 200,
                insideText: Text('Visszatekintés az elmúlt hónap kiadásaira, más felhasználók adataihoz viszonyítva \n\n'
                  'Visszajelzés a költési tendenciákról hasonló anyagi helyzetben lévő felhasználók körében. ',
                  style: const TextStyle(color:Colors.white,fontSize:14, fontWeight:FontWeight.bold))),
          ],
        ),
      ],
    );
  }
}

class MyBox extends StatelessWidget {
  final Color color;
  final double? height;
  final Text? insideText;

  const MyBox(this.color, {super.key, this.height, this.insideText});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        color: color,
        height: (height == null) ? 150 : height,
        child: (insideText == null)
            ? null
            : Center(
          child: insideText,
        ),
      ),
    );
  }
}

class MainPage extends State<OTPAppPage> {
  bool isLogin = false;
  final _pageController = PageController(initialPage: 0);
  final _controllerBackground = ScrollController();
  final _controllerText = ScrollController();

  void scrollListener() {
    _controllerBackground.jumpTo(_controllerText.offset);
  }

  @override
  void initState() {
    super.initState();
    _controllerText.addListener(scrollListener);
    if(backend.currentUser == null)
    {
      login();
    }
  }

  @override
  void dispose()
  {
    _pageController.dispose();
    _controllerText.removeListener(scrollListener);
    _controllerBackground.dispose();
    _controllerText.dispose();
    super.dispose();
  }

  void login() async
  {
    //tells ui to refresh
    setState(() {
      isLogin = true;
    });
    backend.currentUser = await backend.getUserInfo(3);
    print(backend.currentUser!.name);
    setState((){
      isLogin=false;
    });
  }

  void rewindTapped()
  {
    print("Rewind tapped");
    Navigator.push(context, MaterialPageRoute(builder: (context) => const RewindStartupPage()));
  }

  String getMonogram(String name)
  {
    String ret = "";
    List<String> splitted = name.split(' ');
    for(var i = 0; i < splitted.length; i++)
    {
      ret += splitted[i][0];
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller:_pageController,
      children: [
        Scaffold(
          body: Stack(
            children: <Widget>
            [
              Container(
                child: SingleChildScrollView(
                  controller: _controllerBackground,
                  scrollDirection: Axis.vertical,
                  child: Image.asset("resources/images/main_blank.jpg"),
                ),
              ),
              SingleChildScrollView(
                controller: _controllerText,
                scrollDirection: Axis.vertical,
                child: Container(
                  //color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  height: 1700,
                  child: Column(
                    children: <Widget> [
                        Row(
                        children: [
                          Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/14.5,bottom:0,right:0,left:0))
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left:MediaQuery.of(context).size.width / 11,bottom:0,right:0,top:0), //apply padding to all four sides
                              child: Text(backend.currentUser == null ? "KP" : getMonogram(backend.currentUser!.name!),
                                style: const TextStyle(color: colorOTPdarkGrey),
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.only(left:MediaQuery.of(context).size.width / 17,bottom:0,right:0,top:0), //apply padding to all four sides
                              child: Text(backend.currentUser == null ? "Kiss Péter" : '${backend.currentUser!.name}',
                                style: const TextStyle(color: colorOTPwhite),
                              )
                          ),
                          Padding(
                            padding: EdgeInsets.only(left:MediaQuery.of(context).size.width/ 2.5,bottom:0,right:0,top:0), //apply padding to all four sides
                            child: GestureDetector(
                              onTap: () {rewindTapped();},
                              child: Container(
                                height: 20,
                                width: 20,
                                child: Image.asset("resources/images/rewind_icon_small_color.png", fit: BoxFit.cover), //TODO: grey if data not ready
                              ),
                            ),
                          ),
                        ],
                      ),
                        Row(
                        children: [
                          Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/8.5,left:MediaQuery.of(context).size.width/10),
                              child: Text(backend.currentUser == null ? "600 000 Ft" : '${backend.currentUser!.name}',
                                style: const TextStyle(color: colorOTPwhite),)  //TODO: real money value from db
                          ),
                        ],
                      ),
                      Container(
                        child:
                          Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/2.46,),
                              child: Text(backend.currentUser == null ? "500 000 Ft" : '${backend.currentUser!.name}',
                              style: const TextStyle(color: colorOTPgreen, fontSize: 25), textAlign: TextAlign.center,)  //TODO: real spend value from db
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(alignment: FractionalOffset.bottomCenter , child:Image.asset("resources/images/hud_main.jpg")),
            ],
          ),
        )
      ],
    );
  }
}


