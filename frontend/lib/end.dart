import 'package:flutter/material.dart';
import "backend.dart" as backend;
import 'main.dart';

class EndScreen extends StatelessWidget{
  final backend.User? user;

  const EndScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: colorOTPdarkGrey,
        appBar: AppBar(
          title: const Text(
            'Havi visszatekintő',
            style: TextStyle(color: colorOTPwhite, fontSize: 14)
          ),
          centerTitle: true,
          backgroundColor: colorOTPdarkGrey,
          leading: Padding(padding: const EdgeInsets.all(7.5), child: ElevatedButton(
              onPressed: () {
                if(firstTime)
                  {
                    firstTime=false; Navigator.pop(context); Navigator.pop(context); Navigator.pop(context);
                  }
                  else{
                  Navigator.pop(context); Navigator.pop(context);
                }
                },
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
    return Column( children: <Widget>[Container(
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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Text(
                backend.currentUser!=null ? 'TOP ${backend.currentUser!.storyContent[0].percentage}%' : 'TOP 5%', // TODO inject user data
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
                backend.currentUser!=null ? '${backend.currentUser!.avgSpend}' : '500 345 Ft', // TODO inject user data
                style: const TextStyle(
                  fontSize: 16,
                  color: colorOTPwhite,
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),],
            ),
           const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Padding(padding: EdgeInsets.all(2))],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Text(
                'november 1. - november 31',
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
    ),
    const Padding(padding: EdgeInsets.only(top:20.0)),
    Container(
      width: 345.0,
      height: 82.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.0),
          color: colorOTPMidGrey,
          boxShadow: [BoxShadow(
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
      ),child:  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [ Text( 'LEGNEHEZEBB HÓNAPOD 😮‍💨',
    style: TextStyle(
    fontSize: 18,
    color: colorOTPwhite,
    height: 1,
    ),
    textAlign: TextAlign.center,
    ),],
    ),
    const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [ Padding(padding: EdgeInsets.all(4))],
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [ Text(
    backend.currentUser!=null ? backend.monthNamesInHungarian[backend.currentUser?.data?['currentUser']['extendedDataYearly']['hardestMonth']]!.toUpperCase(): 'JÚLIUS', // TODO inject user data
    style: const TextStyle(
    fontSize: 16,
    color: colorOTPgreen,
    height: 1,
    ),
    textAlign: TextAlign.center,
    ),],
    ),
    ]
    )
    ),
    const Padding(padding: EdgeInsets.only(top:20.0)),
    Container(
    width: 345.0,
    height: 82.0,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(24.0),
    color: colorOTPMidGrey,
    boxShadow: [BoxShadow(
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
    ),child:  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [ Text( 'LEGKÖNNYEBB HÓNAPOD 😎', // TODO inject user data
    style: TextStyle(
    fontSize: 18,
    color: colorOTPwhite,
    height: 1,
    ),
    textAlign: TextAlign.center,
    ),],
    ),
    const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [ Padding(padding: EdgeInsets.all(4))],
    ),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [ Text(
    backend.currentUser!=null ? backend.monthNamesInHungarian[backend.currentUser?.data?['currentUser']['extendedDataYearly']['easiestMonth']]!.toUpperCase(): 'JÚLIUS', // TODO inject user data
    style: const TextStyle(
    fontSize: 16,
    color: colorOTPgreen,
    height: 1,
    ),
    textAlign: TextAlign.center,
    ),],
    ),
    const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [ Padding(padding: EdgeInsets.all(2))],
    )]
    )
    ),
      const Padding(padding: EdgeInsets.only(top:20.0)),
      Container(
          width: 345.0,
          height: 82.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: colorOTPMidGrey,
              boxShadow: [BoxShadow(
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
          ),child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Text( 'MEGLÁTOGATOTT ORSZÁGOK ✈️', // TODO inject user data
                style: TextStyle(
                  fontSize: 18,
                  color: colorOTPwhite,
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Padding(padding: EdgeInsets.all(4))],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Text(
                backend.currentUser!=null ? '${backend.currentUser?.data!["currentUser"]["extendedDataYearly"]["visitedCountriesThisYear"]}': '5', // TODO inject user data
                style: const TextStyle(
                  fontSize: 16,
                  color: colorOTPgreen,
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Padding(padding: EdgeInsets.all(2))],
            )]
      )
      ),

      const Padding(padding: EdgeInsets.only(top:20.0)),
      Container(
          width: 345.0,
          height: 82.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.0),
              color: colorOTPMidGrey,
              boxShadow: [BoxShadow(
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
          ),child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Text( 'KEDVENC KERESKEDŐ 💸', // TODO inject user data
                style: TextStyle(
                  fontSize: 18,
                  color: colorOTPwhite,
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Padding(padding: EdgeInsets.all(4))],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Text(
                backend.currentUser!=null ? '${backend.currentUser?.data!["currentUser"]["extendedDataYearly"]["favouriteVendor"]}': 'SPAR', // TODO inject user data
                style: const TextStyle(
                  fontSize: 16,
                  color: colorOTPgreen,
                  height: 1,
                ),
                textAlign: TextAlign.center,
              ),],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ Padding(padding: EdgeInsets.all(2))],
            )]
      )
      )
    ]
    );

  }
}
