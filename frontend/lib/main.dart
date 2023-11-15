import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import "backend.dart" as backend;
import 'dart:math' as math;

void main() {
  runApp(const OTPRewind());
}

const ColorFilter greyscale = ColorFilter.matrix(<double>[
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0,      0,      0,      1, 0,
]);
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

  //TODO design
  @override
  Widget build(BuildContext context) {

    return Container( color: colorOTPdarkGrey,
        child:Column(
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top:45)),
            const Row(
              children: [
                MyBox(colorOTPgreen, insideText: Text('IDEJE  \nVISSZATEKINTENI.',style: TextStyle(color:Colors.white,fontSize:35))) // TODO Mybox would look cooler if it had rounded edges
              ],
            ),
             Row(children:  <Widget>[
              const Padding(padding: EdgeInsets.only(left:50)),
              Expanded(child:Image.asset("resources/images/rewind_icon.png",fit:BoxFit.fill)),
              const Padding(padding: EdgeInsets.only(right:50))
            ]),
            const Row(
              children: [
                MyBox(colorOTPgreen,
                    insideText: Text('Visszatekintés az elmúlt hónap kiadásaira, más felhasználók adataihoz viszonyítva \n\n'
                      'Visszajelzés a költési tendenciákról hasonló anyagi helyzetben lévő felhasználók körében. ',
                      style: TextStyle(color:Colors.white,fontSize:14, fontWeight:FontWeight.bold))),
              ],
            ),
            TextButton(
              style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered))
              return Colors.greenAccent.withOpacity(0.04);
              if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.pressed))
              return Colors.greenAccent.withOpacity(0.12);
              return null; // Defer to the widget's default.
              },
              ),
              ),
              onPressed: () { }, // TODO: build story pages and slide through them like in Instagram (time limit, or tap to skip)
              child: const Text('Kezdjünk bele!')
            )
          ],
      )
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
  final _rewindIconImage = Image.asset("resources/images/rewind_icon_small_color.png", fit: BoxFit.cover);

  void scrollListener() {
    _controllerBackground.jumpTo(_controllerText.offset);
  }

  @override
  void initState() {
    super.initState();
    _controllerText.addListener(scrollListener);
    if(backend.currentUser == null)
    {
      print("logging in...");
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
    print(backend.currentUser?.name);
    setState((){
      isLogin=false;
    });
  }

  void rewindTapped()
  {
    print("Rewind tapped");
    if(backend.currentUser!=null ) // TODO && backend.currentUser?.extendedData != null)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const RewindStartupPage()));
      }

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
          backgroundColor: colorOTPdarkGrey,
          body: Stack(
            children: <Widget>
            [
              Container(
                child: SingleChildScrollView(
                  controller: _controllerBackground,
                  scrollDirection: Axis.vertical,
                  child:
                  SizedBox(width:MediaQuery.of(context).size.width, child:Image.asset("resources/images/main_blank.jpg", fit:BoxFit.cover),)
                ),
              ),
              SingleChildScrollView(
                controller: _controllerText,
                scrollDirection: Axis.vertical,
                child: SizedBox(
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
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: backend.currentUser == null // TODO  backend.currentUser?.extendedData == null
                                ? ColorFiltered( colorFilter: greyscale,
                                    child:_rewindIconImage ) :
                                _rewindIconImage
                              ),
                            ),
                          ),
                        ],
                      ),
                        Row(
                        children: [
                          Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/8.5,left:MediaQuery.of(context).size.width/10),
                              child: Text(backend.currentUser == null ? "600 000 Ft" : '${backend.currentUser!.balance}',
                                style: const TextStyle(color: colorOTPwhite),)
                          ),
                        ],
                      ),
                        Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/4.1,),
                            child: Transform.rotate(angle: -math.pi / 1.2,
                              //TODO: set Android model to Galaxy S20 Plus (or same aspect ratio), and adjust element to match with bg image
                              //TODO: best if it works with iPhone and Android as well
                              child: CircularPercentIndicator(
                                radius: 130,
                                lineWidth: 12.0,
                                percent:0.2, //todo max % current spent
                                center: Transform.rotate(angle: math.pi / 1.2,
                                        child: Padding(padding: const EdgeInsets.only(top:20),
                                                child: Text(backend.currentUser == null ? "600 000 Ft" : '${backend.currentUser!.name}',
                                                style: const TextStyle(color: colorOTPgreen, fontSize: 20),) //TODO: real money value from db)
                                                ),
                                ),
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: colorOTPgreen,
                                backgroundColor: Colors.transparent,
                              ),)
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


