import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:otp_rewind/main.dart';
import "backend.dart" as backend;

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
      _content.add(Content(name: element['name'], percentage: element['topPercentage'], amount: element['amount'], type: getType(element['type'])));
    }
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
                //TODO REAL CONTENT, RN ITS A PALCEHOLDER
                return Container(
                  color: colorOTPdarkGrey,
                  child: MyBox(colorOTPgreen,100,20,Text(cont.name))
                );
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
            var count = 0;
            Navigator.popUntil(context, (route) {
              return count++ == 2;
            });
        }
      });
    }else if(dx > 2 * screenWidth / 3 ) {
      setState(() {
        if (_currentIndex + 1 < widget.story._content.length) {
          _currentIndex += 1;
          _loadStory(story: widget.story._content[_currentIndex]);
        } else {
          //TODO: open up the details page
          _loadStory(story: widget.story._content[_currentIndex]);
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
          padding: const EdgeInsets.symmetric(horizontal: 1.5),
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