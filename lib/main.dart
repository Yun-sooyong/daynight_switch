import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DayNightSwitch(),
    ),
  );
}

class DayNightSwitch extends StatefulWidget {
  DayNightSwitchState createState() => DayNightSwitchState();
}

class DayNightSwitchState extends State<DayNightSwitch> {
  bool _switchValue = false;
  Color _backColor = Color(0xff77d2ff);
  var _text = 'Morning';
  bool _animationState = false;

  /*
  16진수 + 불투명도(ff=255) + Hex
  => 0xff00264b
   */
  // 색 저장
  Color nightBackgroundColor = Color(0xff00264b);
  Color dayBackgroundColor = Color(0xff77d2ff); // 대체 컬러 : 0xff77d2ff 0xff3AA5F8

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    //var screenWidth = MediaQuery.of(context).size.width;

    String _sunImg = "assets/images/sun.png";
    String _moonImg = "assets/images/moon.png";
    String _mauntain = "assets/images/ice_mauntain.png";

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 가운데 원
            Container(
              alignment: Alignment.topCenter,
              height: screenHeight * 0.60,
              padding: EdgeInsets.only(top: 80),
              margin: EdgeInsets.only(left: 30, right: 30, top: 30),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(_mauntain),
                  alignment: Alignment.bottomCenter,
                  scale: 1,
                ),
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.black12,
                  width: 2,
                ),
                color: _backColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              // 이미지 부분
              child: Column(
                children: [
                  AnimatedCrossFade(
                    duration: const Duration(milliseconds: 350),
                    firstChild: Image(
                      image: AssetImage(_moonImg),
                      height: 100,
                      width: 100,
                    ),
                    secondChild: Image(
                      image: AssetImage(_sunImg),
                      height: 100,
                      width: 100,
                    ),
                    crossFadeState: _animationState
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                  ),
                ],
              ),
            ),
            // 텍스트 부분
            // 가운데 정렬, 마진 25, 폰트크기 30, 볼드
            Container(
              height: screenHeight * 0.1,
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: 25),
              child: Text(
                'Good $_text',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            // 스위치 부분
            Center(
              child: Switch(
                value: _switchValue,
                onChanged: (value) {
                  setState(() {
                    // 스위치 클릭시 : 배경 색, 텍스트, 이미지 애니메이션 변경
                    _switchValue = value;
                    _backColor =
                        value ? nightBackgroundColor : dayBackgroundColor;
                    _text = value ? 'Night' : 'Morning';
                    _animationState = !_animationState;
                  });
                },
                // 스위치 컬러 변경
                // active = night // inactive = day
                activeTrackColor: Colors.lightBlueAccent,
                activeColor: nightBackgroundColor,
                activeThumbImage: AssetImage(_moonImg),
                inactiveTrackColor: nightBackgroundColor,
                inactiveThumbColor: Colors.lightBlueAccent,
                inactiveThumbImage: AssetImage(_sunImg),
              ),
            )
          ],
        ),
      ),
    );
  }
}
