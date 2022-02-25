import 'package:flutter/material.dart';
import 'dart:math';
import 'fdot.dart';
// import 'package:floating_dots/floating_dots.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'dart:async';


void main() => runApp(GetMaterialApp(home:Home()));

class Controller2 extends GetxController{
  var count = 0.obs;
  increment(){
    count.value =Random().nextInt(10);
    // count++;
  }

}


class Home2 extends StatelessWidget {

  @override
  Widget build(context) {

    // Get.put()을 사용하여 클래스를 인스턴스화하여 모든 "child'에서 사용가능하게 합니다.
    final Controller2 b = Get.put(Controller2());
    
    return Scaffold(
      // count가 변경 될 때마다 Obx(()=> 를 사용하여 Text()에 업데이트합니다.
      appBar: AppBar(title: Obx(() => Text("Clicks: ${b.count}"))),

      // 8줄의 Navigator.push를 간단한 Get.to()로 변경합니다. context는 필요없습니다.
      body: Center(child: ElevatedButton(
              child: Text("Go to Other"), onPressed: () => Get.to(Other()))),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: b.increment));
  }
}

class Other extends StatelessWidget {
  // 다른 페이지에서 사용되는 컨트롤러를 Get으로 찾아서 redirect 할 수 있습니다.
  final Controller2 b = Get.find();

  @override
  Widget build(context){
     // 업데이트된 count 변수에 연결
    return Scaffold(body: Center(child: Text("${b.count}")));
  }
}



class Controller extends GetxController{
  var pixelRatio = Get.pixelRatio;
  // //Size in physical pixels
  var physicalScreenSize = Get.size;
  double physicalWidth = Get.width;
  double physicalHeight = Get.height; 
  //Size in logical pixels
  double logicalWidth = window.physicalSize.width  / Get.pixelRatio;
  double logicalHeight = window.physicalSize.height  / Get.pixelRatio;
  //Padding in physical pixels
  double padding =0;

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
  RxBool _visible = false.obs;

  RandomeSeed(){
    // physicalWidth = physicalScreenSize.width;
    // physicalHeight = physicalScreenSize.height; 

  //Size in logical pixels
    // logicalWidth = window.physicalSize.width / pixelRatio;
    // logicalHeight = window.physicalSize.height / pixelRatio;

  //Padding in physical pixels
    // padding = window.padding;

  //Safe area paddings in logical pixels
    paddingLeft = window.padding.left / window.devicePixelRatio;
    paddingRight = window.padding.right / window.devicePixelRatio;
    paddingTop = window.padding.top / window.devicePixelRatio;
    paddingBottom = window.padding.bottom / window.devicePixelRatio;

  //Safe area in logical pixels
    safeWidth = logicalWidth - paddingLeft - paddingRight;
    safeHeight = logicalHeight - paddingTop - paddingBottom;
    textHeightSeed.value = Random().nextInt(safeHeight.floor()).toDouble();
    textWidthSeed.value = Random().nextInt(safeWidth.floor()).toDouble();
    _visible.value = true;
    Timer(Duration(seconds: 5),(){
      _visible.value = false;
    });
  }
} 


class Home  extends StatelessWidget {
  // const Home ({ Key? key }) : super(key: key); //필요없낭? 잘모르겟당

  @override
  Widget build(BuildContext context){

    final Controller c = Get.put(Controller());

    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    // var padding = MediaQuery.of(context).padding;
    // double safeHeight = height - padding.top - padding.bottom;

    // RxDouble textHeightSeed = Random().nextInt(safeHeight.floor()).toDouble().obs;
    // RxDouble textWidthSeed = Random().nextInt(width.floor()).toDouble().obs;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Stack(
        children: [
          Obx(()=>Positioned(
              top: c.textHeightSeed.value,
              right : c.textWidthSeed.value,
              child:AnimatedOpacity(
          // If the widget is visible, animate to 0.0 (invisible).
            // If the widget is hidden, animate to 1.0 (fully visible).
              opacity: c._visible.value ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              // The green box must be a child of the AnimatedOpacity widget.
              child: Stack(
                  children: [
                    Text("${c.textHeightSeed} I love you"),
                  ],
                )),
            ),
          ),
          FloatingDotGroup(
          number: 10,
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
        Center(child: InkWell(child: Container(
            padding: EdgeInsets.all(12.0),
            child: Text("Touch me", style: TextStyle(fontSize: 24),),
          ),
          onTap: (){
            c.RandomeSeed();
          },
          )
        ),

      ],
      )
    );
  }
}
