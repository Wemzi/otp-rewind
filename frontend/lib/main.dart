import 'package:flutter/material.dart';
import 'package:http/http.dart';
import "backend.dart" as backend;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTP Rewind',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'OTP Rewind Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final lightGreen = Colors.green.shade300;
final mediumGreen = Colors.green.shade600;
final darkGreen = Colors.green.shade900;

//TODO: has to be stateful, as user informations are popping up here
class OpeningPage extends StatefulWidget {

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
            MyBox(lightGreen,),
            MyBox(lightGreen),
          ],
        ),
        MyBox(mediumGreen, text: backend.currentUser == null ? "" : '${backend.currentUser!.name}'),
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
class _OpeningPageState extends State<OpeningPage> {
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
        Row(
          children: [
            MyBox(darkGreen,height: 50),
          ],
        ),
        Row(
          children: [
            MyBox(lightGreen,),
            MyBox(lightGreen),
          ],
        ),
        MyBox(mediumGreen, text: backend.currentUser == null ? "" :
                                '${backend.currentUser!.name}'),
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



class MyPage1Widget extends StatelessWidget {
  const MyPage1Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            MyBox(darkGreen, height: 50),
          ],
        ),
        Row(
          children: [
            MyBox(lightGreen, text: 'Üdvözöljük! '),
            MyBox(lightGreen),
          ],
        ),
        MyBox(mediumGreen, text: 'Story 1'),
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

class MyBox extends StatelessWidget {
  final Color color;
  final double? height;
  final String? text;

  const MyBox(this.color, {super.key, this.height, this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        color: color,
        height: (height == null) ? 150 : height,
        child: (text == null)
            ? null
            : Center(
          child: Text(
            text!,
            style: const TextStyle(
              fontSize: 50,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
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

    setState((){
      isLogin=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller:_pageController,
      children: [
        Scaffold(
          body: Stack(
          children: <Widget>
              [Container(
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
                    width: MediaQuery. of(context). size. width,
                    height: 5331,
                    child: Column(
                      children: <Widget> [
                          const Row(
                            children: [
                              Padding(padding: EdgeInsets.all(27.0))
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left:MediaQuery. of(context). size. width / 5,bottom:0,right:0,top:0), //apply padding to all four sides
                                child: const Text("KISS PÉTER",
                                        style: TextStyle(color: Colors.white),
                                        )
                                ),
                            ],
                          )
                      ],
                    ),
                  ),
                ),
              ],
          ),
        ),
        OpeningPage(),
        const MyPage1Widget(),
      ],
    );
  }
}


