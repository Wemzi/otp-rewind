import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:otp_rewind/main.dart';
import "backend.dart" as backend;
import 'end.dart';


extension ColorBrightness on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lighten([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslLight =
    hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}

enum Type{
  VENDOR,
  COUNTRY,
  CATEGORY,
  UNKNOWN
}

class Content{
  String? _informationText;
  String? _informationPlusInfo;
  String? _statText;
  final String name;
  final int percentage;
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
        _informationText = "KEDVENC KERESKEDŐ\n$name";
        _informationPlusInfo = '"Ebben a hónapban kimagaslóan sokat jártál kedvenc élelmiszerüzletláncodba. Ez 120%-al nagyobb költés mint előző hónapban."'; //TODO AI??
        _statText = "Legmagasabb ${percentage}%";
        case Type.CATEGORY:
        _informationText = "KEDVENC KATEGÓRIA\n$name";
        _informationPlusInfo = "IDE GENERÁLUNK AI-VAL IDE GENERÁLUNK AI-VAL SZÖVEGET MAJD SZÖVEGET MAJDIDE GENERÁLUNK AI-VAL SZÖVEGET MAJD\nIDE GENERÁLUNK AI-VAL SZÖVEGET MAJD\nIDE GENERÁLUNK AI-VAL SZÖVEGET MAJD\nIDE GENERÁLUNK AI-VAL SZÖVEGET MAJD\nIDE GENERÁLUNK AI-VAL SZÖVEGET MAJD\n";
        _statText = "Legmagasabb ${percentage}%";
        case Type.COUNTRY:
        _informationText = "KEDVENC ORSZÁG\n$name";
        _informationPlusInfo = "IDE GENERÁLUNK AI-VAL SZÖVEGET MAJDIDE GENERÁLUNK AI-VAL SZÖVEGET MAJDIDE GENERÁLUNK AI-VAL SZÖVEGET MAJD\nIDE GENERÁLUNK AI-VAL SZÖVEGET MAJD\nIDE GENERÁLUNK AI-VAL SZÖVEGET MAJD\n";
        _statText = "Legmagasabb ${percentage}%";
        default:
        break;
    }
  }

}

class Story{
  final Duration duration;
  final backend.User user;
  List<Content> _content = [];


  Story({
    required this.duration,
    required this.user,
  });

  Type getType(String type)
  {
    switch(type){
      case "vendor":
        return Type.VENDOR;
      case "country":
        return Type.COUNTRY;
      case "Category":
        return Type.CATEGORY;
      default:
        return Type.UNKNOWN;
    }
  }

  void getStoryContent()
  {
    _content = [];
    for(var element in user.data!.json['currentUser']['extendedDataYearly']['topFacts']){
      var content = Content(name: element['name'], percentage: element['topPercentage'], amount: element['amount'], type: getType(element['type']));
      content.updateContentTexts();
      _content.add(content);
    }
  }
}


class StoryBox extends StatelessWidget{
  final Color color1;
  final Color color2;
  final double height;
  final double radius;
  final Widget child;
  double? width = 150;

  StoryBox({this.width, super.key, required this.radius,required this.height, required this.color1,required this.color2,required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(radius!),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color1,color2]
            )
          ),
          child: child,
        )
    );
  }



}


class StoryScreen extends StatefulWidget{
  final Story story;

  const StoryScreen({required this.story});

  @override
  State<StatefulWidget> createState() => _StoryScreenState();

}

class _StoryScreenState extends State<StoryScreen>
    with SingleTickerProviderStateMixin{

  late PageController _pageController;
  late AnimationController _animationController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(vsync: this);

    widget.story.getStoryContent();
    final Content firstContent = widget.story._content.first;
    _loadStory(story: firstContent,animateToPage: false);

    _animationController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        _animationController.stop();
        _animationController.reset();
        setState(() {
          if(_currentIndex + 1 < widget.story._content.length) {
            _currentIndex += 1;
            _loadStory(story: widget.story._content[_currentIndex]);
          }else{
            //last story rn a loop after -> details page
            _loadStory(story: widget.story._content[_currentIndex]);
          }
        });
      }
    });
  }
  Widget _createPageContent(Content cont)
  {
    Color colorTheme1 = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    Color colorTheme2 = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    return Container(
      color: colorOTPdarkGrey,
      child: Column(
        children: <Widget>[
            Padding(padding: const EdgeInsets.only(top:60),
                  child:SizedBox(width: 100, height: 100, child: Image.asset("resources/images/rewind_icon.png", fit: BoxFit.cover))
            ),
            Padding(padding: const EdgeInsets.only(top:20),
              child: StoryBox(width: MediaQuery.of(context).size.width/1.1 ,radius: 80, height: MediaQuery.of(context).size.height/2, color1: colorTheme1, color2: colorTheme2,
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            color: colorOTPdarkGrey,
                            height: 50,
                            width: MediaQuery.of(context).size.width/3,
                            child: const Center(child:Text("Információ", style: TextStyle(color: colorOTPgrey, fontSize: 20),)),
                          )
                        ),
                      Padding(padding: const EdgeInsets.only(top: 30),
                          child: StoryBox(width: MediaQuery.of(context).size.width/1.6, radius: 50, color1: colorTheme1.darken(0.1), color2: colorTheme2.darken(0.1), height: 125,
                                  child: Center(child:Text(cont._informationPlusInfo!, style: const TextStyle(color: colorOTPwhite,fontSize: 12, fontWeight: FontWeight.bold)))
                          ),
                      ),
                        Padding(padding: const EdgeInsets.only(top: 30),
                          child: SizedBox(
                            child: Text(cont._informationText!,style: const TextStyle(color: colorOTPwhite, fontSize: 35, fontWeight: FontWeight.bold), textAlign: TextAlign.right,),
                          )
                      ),
                    ],
                  )),
            ),
          Padding(padding: EdgeInsets.only(top:  MediaQuery.of(context).size.height/30),
              child: StoryBox(width: MediaQuery.of(context).size.width/1.1 ,radius: 40, height: MediaQuery.of(context).size.height/6, color1: colorTheme1, color2: colorTheme2,
                child:Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(color: colorOTPdarkGrey,
                        height: 50,
                        width: MediaQuery.of(context).size.width/3,
                          child: const Center(child:Text("Statisztika", style: TextStyle(color: colorOTPgrey, fontSize: 20),)),
                      )
                    ),
                      Padding(padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            child: Text(cont._statText!,style: const TextStyle(color: colorOTPwhite, fontSize: 35, fontWeight: FontWeight.bold), textAlign: TextAlign.right,),
                          )
                      ),
                   ]
                )
          )
          ),
          Padding(padding: EdgeInsets.only(top:  1),
              child: Center(
                child:
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: FloatingActionButton(
                        onPressed: () => {}, //TODO SHARE
                        backgroundColor: colorOTPdarkGrey,
                        foregroundColor: colorOTPgreen,
                        child: const Icon(Icons.share),
                    ),
                  ),
              )
          )
        ],
      )
    );
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final Content cont = widget.story._content[_currentIndex];
    return Scaffold(
      backgroundColor: colorOTPdarkGrey,
      body: GestureDetector(
        onTapDown: (details) => _onTapDown(details,cont),
        child: Stack(
          children: <Widget> [
            PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              itemBuilder: (context, i) {
                widget.story.getStoryContent();
                final Content cont = widget.story._content[i];
                return _createPageContent(cont);
              }
          ),
            Positioned(
                top: 40.0,
                left: 10.0,
                right: 10.0,
                child: Row(
                  children: widget.story._content
                      .asMap()
                      .map((i,e){
                        return MapEntry(i, AnimatedBar(animController: _animationController, position: i, currentIndex : _currentIndex));
                    }).values.toList(),
                )
            )
        ]),
      ),
    );
  }

  void _onTapDown(TapDownDetails details, Content cont)
  {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if(dx < screenWidth / 3){
      setState(() {
        if(_currentIndex - 1 >=0){
          _currentIndex -= 1;
          _loadStory(story: widget.story._content[_currentIndex]);
        }
        else{
          if(firstTime){
            firstTime=false;
            var count = 0;
            Navigator.popUntil(context, (route) {
              return count++ == 2;
            });
            }else{
            Navigator.pop(context);
          }
        }
      });
    }else if(dx > 2 * screenWidth / 3 ) {
      setState(() {
        if (_currentIndex + 1 < widget.story._content.length) {
          _currentIndex += 1;
          _loadStory(story: widget.story._content[_currentIndex]);
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => EndScreen(user: backend.currentUser)));
        }
      });
    }
  }

  void _loadStory({required Content story, bool animateToPage = true})
  {
    _animationController.stop();
    _animationController.reset();
    _animationController.duration = widget.story.duration;
    _animationController.forward();

    if(animateToPage){
      _pageController.animateToPage(_currentIndex, duration: const Duration(microseconds: 1), curve: Curves.easeInOut);
    }
  }
}

class AnimatedBar extends StatelessWidget{
  final AnimationController animController;
  final int position;
  final int currentIndex;

  const AnimatedBar({
    Key? key,
    required this.animController,
    required this.position,
    required this.currentIndex,
  }) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Padding(
          padding: const EdgeInsets.only(top: 10,right: 5.5),
          child: LayoutBuilder(
            builder: (context, constraints){
              return Stack(
                children: <Widget>[
                  _buildContainer(
                    double.infinity,
                    position < currentIndex ? colorOTPwhite : colorOTPwhite.withOpacity(0.5),
                  ),
                  position == currentIndex
                    ? AnimatedBuilder(
                      animation: animController,
                      builder: (context, child){
                        return _buildContainer(
                          constraints.maxWidth * animController.value,
                          colorOTPwhite,
                        );
                      },
                      )
                      : const SizedBox.shrink(),
                ],
              );
            },
          )
      )
    );
  }
  
  Container _buildContainer(double width, Color color){
    return Container(
      height: 5.0,
      width: width,
      decoration: BoxDecoration(
        color:color,
        borderRadius: BorderRadius.circular(3.0)
      ),
    );
  }

}