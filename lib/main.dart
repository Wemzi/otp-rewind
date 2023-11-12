import 'package:flutter/material.dart';
import 'package:http/http.dart';
import "backend.dart";

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


class OpeningPage extends StatelessWidget {
  User? currentUser;

  OpeningPage(User? currentUser, {super.key});

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
        MyBox(mediumGreen, text: currentUser == null ? "" : currentUser!.name),
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
  int _counter = 0;
  bool? isLogin;
  final _pageController = PageController(initialPage: 0);
  User? currentUser;

  @override
  void dispose()
  {
    _pageController.dispose();
    super.dispose();
  }

  void login() async
  {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

    _counter++;
    });
    isLogin = true;
    currentUser = await getUserInfo(2);
    print(currentUser?.name);
    setState((){
      isLogin=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller:_pageController,
      children: [
        OpeningPage(currentUser),
        const MyPage1Widget(),
        Scaffold(
          body: Center( child:
          Column(children:
          <Widget>[
            const Padding(padding: EdgeInsets.only(top:100.0)),
            const Text(
              'Press the log in button at the bottom:',
            ),
            Text(currentUser == null ?
                "No logged in user":
              '${currentUser?.name}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ]
          )
          ),
          floatingActionButton:
          FloatingActionButton(onPressed: login),
        ),
      ],
    );
  }
}


