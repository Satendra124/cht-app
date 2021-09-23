import 'package:cht/util/colorConstants.dart';
import 'package:flutter/material.dart';

class ScreenTimeWidget extends StatelessWidget {
  final Duration screenTime;

  const ScreenTimeWidget({Key key, @required this.screenTime})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        height: 100,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorLight.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Screen Time",
                style: TextStyle(color: ColorLight.black.withOpacity(0.6)),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                screenTime.inHours.toString() +
                    ":" +
                    (screenTime.inMinutes - screenTime.inHours * 60).toString(),
                style: TextStyle(
                  color: ColorLight.themeColor,
                  fontFamily: "LukiestGuy",
                  fontSize: 30,
                ),
              ),
            )
          ],
        ));
  }
}
