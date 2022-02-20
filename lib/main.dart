import 'package:flutter/material.dart';
import 'fdot.dart';
// import 'package:floating_dots/floating_dots.dart';

void main() => runApp(MaterialApp(home:MyApp()));

class MyApp extends StatefulWidget {
  // final String title;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isElevated = false;

  @override
  Widget build(BuildContext context){
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
          Center(
            child: FloatingDotGroup(
              number: 500,
              direction: Direction.up,
              trajectory: Trajectory.straight,
              size: DotSize.small,
              colors: [
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.yellow,
                Colors.purple,
                Colors.orange
              ],
              opacity: 0.5,
              speed: DotSpeed.slow,
            ),
          ),
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




