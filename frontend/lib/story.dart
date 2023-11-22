import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:otp_rewind/main.dart';
import "backend.dart" as backend;
import 'backend.dart';
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

class Story{
  final Duration duration;
  final backend.User user;

  Story({
    required this.duration,
    required this.user,
  });
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
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [color1,color2]
            ),
            boxShadow: [
              BoxShadow(
              color: colorOTPgrey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, -2), // changes position of shadow
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 2), // changes position of shadow
            )
            ]
          ),
          child: child,
        )
    );
  }
}

class StoryScreen extends StatefulWidget{
  final Story story;

  const StoryScreen({super.key, required this.story});

  @override
  State<StatefulWidget> createState() => _StoryScreenState();

}

class _StoryScreenState extends State<StoryScreen>
    with SingleTickerProviderStateMixin{

  bool isPushed = false;
  late PageController _pageController;
  late AnimationController _animationController;
  int _currentIndex = 0;

  void _pushNavigator(BuildContext context){
    isPushed = true;
    Navigator.push(context, MaterialPageRoute(builder: (context) => EndScreen(user: backend.currentUser)));
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(vsync: this);

    final Content firstContent = widget.story.user.storyContent.first;
    _loadStory(story: firstContent,animateToPage: false);

    _animationController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        _animationController.stop();
        _animationController.reset();
        setState(() {
          if(_currentIndex + 1 < widget.story.user.storyContent.length) {
            _currentIndex += 1;
            _loadStory(story: widget.story.user.storyContent[_currentIndex]);
          }else{
            _animationController.stop();
            _pushNavigator(context);
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
                                  child: Center(child:Text(cont.informationPlusInfo!, style: const TextStyle(color: colorOTPwhite,fontSize: 12, fontWeight: FontWeight.bold)))
                          ),
                      ),
                        Padding(padding: const EdgeInsets.only(top: 30),
                          child: SizedBox(
                            child: Text(cont.informationText!,style: const TextStyle(color: colorOTPwhite, fontSize: 35, fontWeight: FontWeight.bold), textAlign: TextAlign.right,),
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
                            child: Text(cont.statText!,style: const TextStyle(color: colorOTPwhite, fontSize: 35, fontWeight: FontWeight.bold), textAlign: TextAlign.right,),
                          )
                      ),
                   ]
                )
          )
          ),
          Padding(padding: const EdgeInsets.only(top:  1),
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
    final Content cont = widget.story.user.storyContent[_currentIndex];
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: colorOTPdarkGrey,
        body: GestureDetector(
          onTapDown: (details) => _onTapDown(details,cont),
          onHorizontalDragUpdate: (details) {
              int sensitivity = 8;
              if (details.delta.dx > sensitivity) {
                if(firstTime)
                {
                  firstTime = false;
                  Navigator.pop(context); Navigator.pop(context);
                }else{
                  Navigator.pop(context);
                }
              } else if(details.delta.dx < -sensitivity){
                _animationController.stop();
                _pushNavigator(context);
              }
            },
          onTapUp: (details) => {
            if(!isPushed) _animationController.forward()
          },
          child: Stack(
            children: <Widget> [
              PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemBuilder: (context, i) {
                  final Content cont = widget.story.user.storyContent[i];
                  return _createPageContent(cont);
                }
            ),
              Positioned(
                  top: 40.0,
                  left: 10.0,
                  right: 10.0,
                  child: Row(
                    children: widget.story.user.storyContent
                        .asMap()
                        .map((i,e){
                          return MapEntry(i, AnimatedBar(animController: _animationController, position: i, currentIndex : _currentIndex));
                      }).values.toList(),
                  )
              )
          ]),
        ),
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
          _loadStory(story: widget.story.user.storyContent[_currentIndex]);
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
        if (_currentIndex + 1 < widget.story.user.storyContent.length) {
          _currentIndex += 1;
          _loadStory(story: widget.story.user.storyContent[_currentIndex]);
        } else {
          _animationController.stop();
          _pushNavigator(context);
        }
      });
    }else{ //MID HOLD
      _animationController.stop();
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