import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:math';

import 'home.dart';

class Result extends StatelessWidget {
  final int random;
  Result({required this.random});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
                  backgroundColor: Colors.white,
          actions: [IconButton(color: Colors.black, onPressed: (){
           Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
            
          }, icon: Icon(Icons.close))],
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: const Text(
            'Result',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(40),
          child:
        
        Card(
            elevation: 2,
            color: Colors.white,
            
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 80),
                  height: 270,
                  width: 190,
                 child: CircularPercentIndicator(
                      radius: 70.0,
                      lineWidth: 5.0,
                      percent: random/100,
                      center:  Text(random.toString(), style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
                      progressColor: Colors.blueAccent,
                    ),
                ),
              ), 
              Text("Well Done!", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              Text("$random% of your posture were \n     alike to the experts.", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
            ]))));
  }
}
