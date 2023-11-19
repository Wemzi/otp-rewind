import 'package:flutter/material.dart';
import "backend.dart" as backend;
import 'main.dart';

class EndScreen extends StatelessWidget{
  final backend.User? user;

  const EndScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorOTPdarkGrey,
      appBar: AppBar(
        title: const Text(
          'Havi visszatekintő',
          style: TextStyle(color: colorOTPwhite, fontSize: 14)
        ),
        centerTitle: true,
        backgroundColor: colorOTPdarkGrey,
        leading: Padding(padding: const EdgeInsets.all(7.5), child: ElevatedButton(
            onPressed: () { Navigator.pop(context); Navigator.pop(context); Navigator.pop(context); },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(5),
              backgroundColor: colorOTPdarkGrey,
            ),
            child: const Icon(Icons.arrow_back_ios_new, color: colorOTPgreen),
          ),
        ),
      ),
      body: const Column(
          children: [
            Row(children: [Padding(padding: EdgeInsets.all(10))]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    _OverallSpendingWidget(),
                  ],
                ),
              ],
            )
          ],
        ),
    );
  }
}

class _OverallSpendingWidget extends StatelessWidget {
  const _OverallSpendingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210.0,
      height: 82.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
        color: colorOTPdarkGrey,
        boxShadow: [
          BoxShadow(
          color: colorOTPgrey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 10,
          offset: Offset(0, -2), // changes position of shadow
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 1), // changes position of shadow
          )
        ]
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Text(
                'TOP 2%', // TODO inject user data
                style: TextStyle(
                  fontSize: 18,
                  color: colorOTPwhite,
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Padding(padding: EdgeInsets.all(4))],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Text(
                '500 345 Ft', // TODO inject user data
                style: TextStyle(
                  fontSize: 16,
                  color: colorOTPwhite,
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Padding(padding: EdgeInsets.all(2))],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Text(
                'október 1. - október.31', // TODO inject user data
                style: TextStyle(
                  fontSize: 12,
                  color: colorOTPgreen,
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),],
            )
          ],
        )
      ),
    );
  }
}
