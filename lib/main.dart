// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'dart:math';
import 'fdot.dart';
// import 'package:floating_dots/floating_dots.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'dart:async';
import 'package:csv/csv.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart'; //rootbundle

void main() => runApp(GetMaterialApp(home: Home()));

class randomPostion {
  randomPostion(dl, sh, sw) {
    dataLength = dl;
    safeHeight = sh;
    safeWidth = sw;
  }
  late int dataLength;
  late double safeHeight;
  late double safeWidth;

  RxDouble textHeightSeed = 90.0.obs;
  RxDouble textWidthSeed = 110.0.obs;
  RxBool _visible = false.obs;
  RxInt rIndex = 0.obs;

  RandomPostionVisible() {
    rIndex.value = Random().nextInt(dataLength - 1);
    textHeightSeed.value = Random().nextInt(safeHeight.floor()).toDouble();
    textWidthSeed.value = Random().nextInt(safeWidth.floor() - 100).toDouble();
    _visible.value = true;
    Timer(const Duration(seconds: 2), () {
      _visible.value = false;
    });
  }
}

class Controller extends GetxController {
  List numberList = [];
  late List<dynamic> _data;
  late Future<List<dynamic>> _data2;

  Future<List<dynamic>> _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/htda.csv");
    List<dynamic> _listData = const CsvToListConverter().convert(_rawData);
    print('rawData $_rawData');
    print('_listData $_listData');

    _data = _listData;

    return _listData;
  }

  @override
  onInit() {
    // _dataRequiredForBuild = _fetchAllData();

    _data2 = _loadCSV();
    print('onInit start');
    calSafeRange();
    // RandomIndex();
  }

  calSafeRange() {
    paddingLeft = window.padding.left / window.devicePixelRatio;
    paddingRight = window.padding.right / window.devicePixelRatio;
    paddingTop = window.padding.top / window.devicePixelRatio;
    paddingBottom = window.padding.bottom / window.devicePixelRatio;

    //Safe area in logical pixels

    safeWidth = logicalWidth - paddingLeft - paddingRight;
    safeHeight = logicalHeight - paddingTop - paddingBottom;
    // print(logicalWidth);
    // print("get Ratio ${Get.pixelRatio}");
    // print("windowsdevicePecelRatio ${window.devicePixelRatio}");
    // print("safeWidth $safeWidth safe Height $safeHeight");
  }

  var pixelRatio = Get.pixelRatio;
  // //Size in physical pixels
  var physicalScreenSize = Get.size;
  double physicalWidth = Get.width;
  double physicalHeight = Get.height;
  //Size in logical pixels
  double logicalWidth = window.physicalSize.width / Get.pixelRatio;
  double logicalHeight = window.physicalSize.height / Get.pixelRatio;
  //Padding in physical pixels
  double padding = 0;

  //Safe area paddings in logical pixels
  double paddingLeft = 0;
  double paddingRight = 0;
  double paddingTop = 0;
  double paddingBottom = 0;

  //Safe area in logical pixels
  double safeWidth = 0;
  double safeHeight = 0;

  // RxDouble textHeightSeed = {0}.obs;
  // RxDouble textWidthSeed = {0}.obs;
  RxDouble textHeightSeed = 90.0.obs;
  RxDouble textWidthSeed = 110.0.obs;
  RxDouble textHeightSeed2 = 90.0.obs;
  RxDouble textWidthSeed2 = 110.0.obs;

  RxBool _visible = false.obs;
  RxBool _visible2 = false.obs;
  RxInt rIndex = 0.obs;
  RxInt rIndex2 = 0.obs;
  RandomIndex1() {
    rIndex.value = Random().nextInt(_data.length - 1);
    textHeightSeed.value = Random().nextInt(safeHeight.floor()).toDouble();
    textWidthSeed.value = Random().nextInt(safeWidth.floor() - 100).toDouble();
    _visible.value = true;
    Timer(const Duration(seconds: 2), () {
      _visible.value = false;
    });
  }

  RandomIndex2() {
    rIndex2.value = Random().nextInt(_data.length - 1);
    textHeightSeed2.value = Random().nextInt(safeHeight.floor()).toDouble();
    textWidthSeed2.value = Random().nextInt(safeWidth.floor() - 100).toDouble();
    _visible2.value = true;
    Timer(const Duration(seconds: 2), () {
      _visible2.value = false;
    });
  }

  var counter = 1;
  tapFunction() {
    switch (counter % 2) {
      case 1:
        RandomIndex1();
        print('case1 $counter');
        break;
      case 0:
        RandomIndex2();
        print('case0 $counter');
        break;
      default:
    }
    counter++;
  }
}

class Home extends StatelessWidget {
  // const Home ({ Key? key }) : super(key: key); //필요없낭? 잘모르겟당

  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            // Color(0xFFE3170A),
            Color(0xFFA9E5BB),
            // Color(0xFFFCF6B1),
            Color(0xFFF7B32B)
          ],
        ),
      ),
      child: Stack(
        children: [
          FutureBuilder(
            future: c._data2,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Obx(
                  () => Stack(children: [
                    Positioned(
                      top: c.textHeightSeed.value,
                      left: c.textWidthSeed.value,
                      child: AnimatedOpacity(
                          opacity: c._visible.value ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 500),
                          // The green box must be a child of the AnimatedOpacity widget.
                          child: Container(
                            child: Text("${snapshot.data[c.rIndex.value][0]}",
                                style: TextStyle(fontSize: 24)),
                          )),
                    ),
                    Positioned(
                      top: c.textHeightSeed2.value,
                      left: c.textWidthSeed2.value,
                      child: AnimatedOpacity(
                          opacity: c._visible2.value ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 500),
                          // The green box must be a child of the AnimatedOpacity widget.
                          child: Container(
                            child: Text("${snapshot.data[c.rIndex2.value][0]}",
                                style: TextStyle(fontSize: 24)),
                          )),
                    ),
                  ]),
                );
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('스냅샷 에러');
              } else {
                return Text('혹시 몰라서 else문 추가');
              }
            },
          ),
          FloatingDotGroup(
            number: 40,
            direction: Direction.up,
            trajectory: Trajectory.straight,
            size: DotSize.small,
            colors: [
              Color(0xFFA8E6CE),
              Color(0xFFDCEDC2),
              Color(0xFFFFD3B5),
              Color(0xFFFFAAA6),
              Color(0xFFFF8C94)
            ],
            opacity: 0.5,
            speed: DotSpeed.slow,
          ),
          Center(
              child: InkWell(
            child: Container(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Touch me",
                style: TextStyle(fontSize: 24, color: Colors.red[500]),
              ),
            ),
            onTap: () {
              c.tapFunction();
            },
          )),
        ],
      ),
    ));
  }
}
