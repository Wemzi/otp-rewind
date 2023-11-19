import 'package:flutter/material.dart';
import "backend.dart" as backend;

class EndScreen extends StatefulWidget{
  final backend.User user;

  const EndScreen({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => _EndScreenState();

}

class _EndScreenState extends State<EndScreen>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}