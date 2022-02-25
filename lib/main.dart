import 'package:flutter/material.dart';
import 'dart:math';
// import 'fdot.dart';
// import 'package:floating_dots/floating_dots.dart';
import 'package:get/get.dart';


void main() => runApp(MaterialApp(home:MyApp()));

class MyApp extends StatefulWidget {
  // final String title;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isElevated = false;

  final colorizeColors = [
  Colors.grey[500]!,
  Colors.black,
  Colors.grey[500]!,
  ];

  final colorizeTextStyle = TextStyle(
  fontSize: 50.0,
  fontFamily: 'Horizon',
  );


  @override
  Widget build(BuildContext context){

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    double safeHeight = height - padding.top - padding.bottom;



    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: [
          Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds:200),
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color:Colors.grey[300],
                  borderRadius: BorderRadius.circular(50),
                  boxShadow:_isElevated ? [ 
                    BoxShadow(
                      color : Colors.grey[500]!,
                      offset: const Offset(4, 4),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color : Colors.white,
                      offset: Offset(-4,4),
                      blurRadius : 15,
                      spreadRadius : 1
                    )
                  ] : null,
                
              ),
            ),
          ),
          Positioned(
            top: Random().nextInt(safeHeight.floor()).toDouble(),
            right : Random().nextInt(width.floor()).toDouble(),
            child: Text("I love you")),
          Center(
            child : GestureDetector(
              onTap: (){
                setState(() {
                  _isElevated = !_isElevated;
                });
              },
            ),
          ),
        ],
      )
    );
  }
}




