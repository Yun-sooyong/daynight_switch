import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DayNightSwitch(),
  ));
}

class DayNightSwitch extends StatefulWidget {
  DayNightSwitchState createState() => DayNightSwitchState();
}

class DayNightSwitchState extends State<DayNightSwitch> {
  bool _switchValue = false;
  Color _backColor = Color(0xffD0EEFF);
  var _text = 'Morning';

  /*
  16진수 + 불투명도(ff=255) + Hex
  => 0xff00264b
   */
  Color nightBackgroundColor = Color(0xff00264b);
  Color dayBackgroundColor = Color(0xffD0EEFF); // 대체 컬러 : 0xff77d2ff

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    String _sunImg = "assets/images/sun.png";
    String _moonImg = "assets/images/moon.png";
    var _img = AssetImage(_sunImg);

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: screenHeight * 0.6,
              margin: EdgeInsets.only(left: 30, right: 30, top: 30),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black12,
                  width: 2,
                ),
                color: _backColor,
              ),
              child: Center(
                child: Image(
                  image: _img,
                ),
              )
            ),
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
            Center(
              child: Switch(
                value: _switchValue,
                onChanged: (value) {
                  setState(() {
                    _switchValue = value;
                    _backColor =
                        value ? nightBackgroundColor : dayBackgroundColor;
                    _text = value ? 'Night' : 'Morning';
                    _img = value ? AssetImage(_moonImg) : AssetImage(_sunImg);
                  });
                },
                // 스위치 컬러 변경
                activeTrackColor: Colors.lightBlueAccent,
                activeColor: nightBackgroundColor,
                activeThumbImage: AssetImage("assets/images/moon.png",),
                inactiveTrackColor: nightBackgroundColor,
                inactiveThumbColor: Colors.lightBlueAccent,
                inactiveThumbImage: _img,
              ),
            )
          ],
        ),
      ),
    );
  }
}
