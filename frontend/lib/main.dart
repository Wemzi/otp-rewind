import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:otp_rewind/story.dart';
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
const colorOTPdarkGreen = Color.fromARGB(255, 43, 101, 78);
const colorOTPMidGrey = Color.fromARGB(255, 54, 56, 60);
const colorOTPlightGrey = Color.fromARGB(255,160,165,176);
bool firstTime = true;
var formatter = NumberFormat('#,###');

class MyBox extends StatelessWidget {
  final Color color;
  final double? height;
  final Widget? inside;
  final double? radius;

  const MyBox(this.color, this.height, this.radius, this.inside, {super.key});

  @override
  Widget build(BuildContext context) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(radius!),
          child: Container(
              height: height,
              width: MediaQuery.of(context).size.width/1.1,
              color: color,
              child: inside,
          )
      );
  }
}


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

class RewindStartupPage extends StatelessWidget {
  const RewindStartupPage({super.key});

  Story getUser()
  {
    return Story(user: backend.currentUser!, duration: const Duration(seconds: 10));
  }

  @override
  Widget build(BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Container(
            color: colorOTPdarkGrey,
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .size
                    .height / 20, bottom: 0, right: MediaQuery
                    .of(context)
                    .size
                    .width / 1.18),
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('X',
                        style: TextStyle(color: colorOTPwhite, fontSize: 18),)
                  ),
                ),
                MyBox(colorOTPwhite, MediaQuery
                    .of(context)
                    .size
                    .height / 1.8, 20,
                  Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: MediaQuery
                            .of(context)
                            .size
                            .height / 40)),
                        const Text("IDEJE \nVISSZATEKINETNI", style: TextStyle(
                            color: colorOTPdarkGreen,
                            fontSize: 32,
                            fontStyle: FontStyle.normal,
                            decoration: TextDecoration.none)),
                        Padding(padding: EdgeInsets.only(top: MediaQuery
                            .of(context)
                            .size
                            .height / 40)),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 3,
                          width: MediaQuery
                              .of(context)
                              .size
                              .height / 3,
                          child: Image.asset('resources/images/rewind_icon.png',
                              fit: BoxFit.cover),
                        )
                      ]
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .size
                    .height / 40),
                  child: MyBox(colorOTPMidGrey, MediaQuery
                      .of(context)
                      .size
                      .height / 5, 50,
                    Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(top: MediaQuery
                              .of(context)
                              .size
                              .height / 40)),
                          Container(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 15,
                              child: Row(
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.only(
                                      left: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 10),
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: Image.asset(
                                        'resources/images/stat_icon_small.png',
                                        fit: BoxFit.cover,),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(
                                      left: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 20),
                                      child: const Text(
                                          "Visszatekintés az elmúlt hónap kiadásaira, \nmás felhasználók adataihoz viszonyítva",
                                          style:
                                          TextStyle(color: colorOTPgrey,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              decoration: TextDecoration.none))
                                  )
                                ],
                              )
                          ),
                          Container(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 15,
                              child: Row(
                                children: <Widget>[
                                  Padding(padding: EdgeInsets.only(
                                      left: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 10),
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Image.asset(
                                        'resources/images/conv_icon_small.png',
                                        fit: BoxFit.fitWidth,),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(
                                      left: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 40),
                                      child: const Text(
                                          "Visszajelzés a költési tendenciákról hasonló\nanyagi helyzetben lévő felhasználók körében",
                                          style:
                                          TextStyle(color: colorOTPgrey,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              decoration: TextDecoration.none))
                                  )
                                ],
                              )
                          ),
                        ]
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: MediaQuery
                    .of(context)
                    .size
                    .height / 40),
                    child:
                    MyBox(colorOTPwhite, MediaQuery
                        .of(context)
                        .size
                        .height / 15, 100,
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      StoryScreen(story: getUser())));
                            },
                            child: const Text('KEZDJÜK!', style: TextStyle(
                                color: colorOTPdarkGrey, fontSize: 20),)
                        )
                    )
                )
              ],
            )
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
  
  Story getUser()
  {
    return Story(user: backend.currentUser!, duration: const Duration(seconds: 10));
  }
  
  void rewindTapped()
  {
    print("Rewind tapped");
    if(backend.currentUser!=null && firstTime)
    {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const RewindStartupPage()));
    }else if (backend.currentUser!=null){
      Navigator.push(context, MaterialPageRoute(builder: (context) => StoryScreen(story: getUser())));
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
                          Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/15,bottom:0,right:0,left:0))
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
                                child: backend.currentUser == null
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
                          Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/8.9,left:MediaQuery.of(context).size.width/10),
                              child: Text(backend.currentUser == null ? "600 000 Ft" : '${formatter.format(backend.currentUser!.balance).replaceAll(',', ' ')} Ft',
                                style: const TextStyle(color: colorOTPwhite),)
                          ),
                        ],
                      ),
                        Padding(padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/4.3,),
                            child: Transform.rotate(angle: -math.pi / 1.2,
                              child: CircularPercentIndicator(
                                radius: 130,
                                lineWidth: 15.0,
                                percent: backend.currentUser == null ? 0.4 : backend.currentUser!.avgSpend! < 600000 ? 0.6 : 0.3,
                                center: Transform.rotate(angle: math.pi / 1.2,
                                        child: const Padding(padding: EdgeInsets.only(top:20),
                                                child:  Text( "600 000 Ft",
                                                style: TextStyle(color: colorOTPgreen, fontSize: 20),)
                                                ),
                                ),
                                circularStrokeCap: CircularStrokeCap.round,
                                progressColor: colorOTPgreen,
                                backgroundColor: Colors.transparent,
                              ),)
                        ),
                      Padding(padding:EdgeInsets.only(top:MediaQuery.of(context).size.height/30),
                          child: Padding(padding:EdgeInsets.only(left:MediaQuery.of(context).size.width/2.7),
                              child: Text(backend.currentUser == null ? "600 000 Ft" : '${formatter.format(backend.currentUser!.avgSpend).replaceAll(',', ' ')} Ft',
                                style: const TextStyle(color: colorOTPgrey, fontSize: 13),)
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


